**_| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/pages/overview-week-5-2?module_item_id=1685506) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=b9396fdf-6750-4e85-8b57-b4f300d7b9c1) |_**
We will briefly consider heaps for process queuing, and compare CPUs and GPUs for parallelism. Then we will take a little look at distributed computation, describing the basic set-up of data centres, and briefly discussing how they achieve synchronisation and how one interacts with them via Remote Procedure Calls. We then discuss the essentials of cybersecurity.

---
#### Learning Outcomes
- Know the basic set-up of data centres and remote procedure calls.
- Understand the basic principles and uses of hashing and encryption in cybersecurity.
---
## Background Reading
Operating System Concepts (9th) Silberschatz, Galvin and Gagne. ([1](https://github.com/TusharKukra/GateBooks/blob/master/(OS)%20Operating%20System%20Concepts%20(9th%20Ed)%20-%20Gagne%2C%20Silberschatz%2C%20and%20Galvin.pdf), [2](https://drive.uqu.edu.sa/_/mskhayat/files/MySubjects/2017SS%20Operating%20Systems/Abraham%20Silberschatz-Operating%20System%20Concepts%20(9th,2012_12).pdf))
- Chapters 14 and 15 (Security), 
- Chapter 17 (Networks and distributed systems)
---
# Lecture
- **_| [[lecture5.pdf]] |_**

1. [[#Heaps and Heapsort Algorithm]]
	-  [[#Complexity]]
		-  [[#Phase 1 — Building the heap (Organising)]]
		-  [[#Phase 2 — Extracting the sorted list (Sorting)]]
2. [[#CPUs vs GPUs]]
3. [[#Machine Security]]
4. [[#Authentication]]
5. [[#Hashed-Message Authentication]]
6. [[#Hashing vs Encryption]]
7. [[#Symmetric Encryption]]
8. [[#Asymmetric Encryption]]
	- [[#Private/Public Key Encryption 1 Way]]
	- [[#Private/Public Key Encryption 2 Way]]

## Heaps and Heapsort Algorithm
A **binary tree** is a hierarchical data structure where each node has at most two children (left and right), starting from a single root at the top and branching downward along parent-child chains. 

Unlike a binary search tree (where left children are smaller and right children are larger than their parent), a **heap** is a _complete_ binary tree—meaning every level is fully filled except possibly the last, which fills from left to right—that satisfies the **heap property**. In a **min-heap**, every parent node is less than or equal to its children ($\text{Value}[\text{parent}(i)] \le \text{Value}[i]$), ensuring the smallest element always sits at the root.

To turn an unsorted array into a valid min-heap, you run **heapify** on every non-leaf node in a bottom-up fashion, working upward layer by layer toward the root. 

At each parent node, you compare it against its children; if the parent is larger than its smallest child, you swap them. Whenever a larger value is swapped downward, you continue sifting it down through subsequent layers until it is smaller than its new children or reaches a leaf. 

Notice that there is only **one tree structure** in memory (usually stored implicitly as a flat array)—`newlist` is simply a standard output array (or the sorted back portion of the same array) used to collect the elements as they are popped from the root.

```
newlist = [] 
while heap is not empty: 
	append element at top (root) of heap to newlist
	take the element at the bottom-right of the heap and place it at the top 
	run heapify (sift down from the root)
```
### Complexity
There are two phases to Heapsort: building the heap and extracting the sorted list. 
#### Phase 1 — Building the heap (Organising):
Takes an arbitrary, unsorted array and turns it into a valid min-heap in place, without creating a separate tree object in memory. 

Conceptually a flat list can be treated as a complete binary tree simply by reading it level-by-level from left to right. For any node at index $i$ (using 0-based indexing):
- **Left child:** $2i + 1$
- **Right child:** $2i + 2$
- **Parent:** $\lfloor(i - 1) / 2\rfloor$

> Note, this structure means that the trees levels are filled left to right. The lowest level can be incomplete and any new elements would be added to the left-most available slot. 

```
[9, 4, 7, 1, 3, 6, 2]

	 9 (index 0) 
	/ \ 
   4   7 (indices 1, 2) 
  / \ / \ 
 1  3 6  2 (indices 3, 4, 5, 6 — all leaves)
```

Given the tree, we run **bottom-up** `heapify` once so the tree obeys the min-heap rule. This means comparing each non-leaf element with its children ($n$) and also if a parent is swapped with a children, it needs to be compared to all subsequent children ($log \ n$).

Resultantly, the max complexity is $O(\log n)$, through it would be unlikely that every comparison would result in a parent-child swap which then tumbles all the way to the leaves.

At the end of Phase 1, the list is _not_ sorted yet—you only guarantee the **smallest item is at the root** and **every parent is smaller than its children**. 

#### Phase 2 — Extracting the sorted list (Sorting):
Once the heap is built, you run the `while` loop $n$ times. Each iteration extracts the current minimum from the root, moves the last leaf (right-most) to the root, and runs a single top-down `heapify` ($O(\log n)$) to bring the _next_ smallest element to the top. Repeating this extraction $n$ times produces the fully sorted list in $O(n \log n)$ time.
- Because of the parent $\text{Value}[\text{parent}(i)] \le \text{Value}[i]$ condition, we actually get the next smallest item when switching the new root to the smallest children, however, we need to potentially bring the root to the leaves to maintain the parent-child condition, which is the complexity continues to scale with $O(\log n)$

> **Why is the second term $\log n$ instead of $n$?** Because a complete binary tree splits into two branches at every level, a tree with $n$ nodes only has a height of $\log_2 n$. When an element sifts down from the root to a leaf, it only follows **one path** (making one comparison per level), rather than visiting every node in the tree. Thus, a single sift-down takes at most $O(\log n)$ steps, not $O(n)$.

---
## CPUs vs GPUs
CPU = Multiple cores
GPU = Thousands of cores

Unlike a CPU — which dedicates silicon to complex control logic, large caches, and OS-level process management (such as maintaining Process Control Blocks and handling context switches) — a GPU strips away most of that control overhead in favour of thousands of simple arithmetic cores designed for high-throughput parallel computation.

**PCB vs. Control Logic:** A **Process Control Block (PCB)** is actually an **Operating System data structure** stored in RAM (not a physical part of the CPU hardware), though the CPU's control unit and registers are what save and restore state into the PCB during context switches. What GPUs lack compared to CPUs is **complex per-core control logic** (like branch prediction and out-of-order execution) and large per-core caches.

| CPU | GPU |
| :--- | :--- |
| Larger memory capacity | Smaller memory capacity |
| Slower at loading memory in from outside – low bandwidth | Quicker at loading in memory from outside - high bandwidth |
| Does better when process involves lots of data update. | |
| Faster clockspeed, but fewer cores | Slower clockspeed, but more cores. |
| Will be better for **task parallelism**: different tasks done on a big chunk of data simultaneously. | Good for **data parallelism**: repetitive simple task done on many small chunks of data.<br><br>E.g. basic mathematical operations on arrays can be done in parallel. Useful in machine learning. |

---
## Machine Security
Security is made of three key pieces: 
- **Authentication:** identify who each user is 
- **Authorisation:** control who is allowed to do what 
- **Enforcement:** ensure that users only do what they are allowed to do
---
## Authentication
Passwords are the most common approach. The problem arises here is that the host must maintain a copy of the passwords. What if malicious user gains access to this list of passwords?

The solution is to transform the data in such a way that it is difficult to reverse - Hash functions. 

Password -> HashFunction(Password) -> Hashed Password

It is the HashedPasswords which are stored in the host database

A hash function is difficult, or impossible to reverse, therefore, the stored database is of no use to malicious users. 

A hash function h = H(M) has the following key properties: 
1. Given $M$, it is easy to compute $h$. 
2. Given $h$, it is hard to compute $M$. 
3. Given $M$, it is hard to find another $M’$ such that $H(M)=H(M’)$ 
> Usually, any small change in $M$ generates a big change in $h$.

The password itself is never sent publicly or stored. The password passes through the hash function and it is the output that is transferred. 

---
## Hashed-Message Authentication
String secrets appended between host and client. The string is a considered an authentication code. If this is wrong or doesn't exist then message is not legit. 

Used coupled hash functions

---
## Hashing vs Encryption 
Hashing: a one-way process — easy to do, hard to undo.

Encryption: a two-way process, where decoding is possible under conditions…
![[encryption.png]]

## Symmetric Encryption
The same key is used for encoding and decoding. Simple but not very flexible. 

It is risk in the sense that both the client and host end need to fold the encryption key, if either is exposed then the whole process is flawed. 

Basic example is a one-time pad, i.e. a binary chain. Input takes through the pad giving the cipher, but the cipher is a easily reversed back through the same pad

| Component | Byte 1 | Byte 2 | Byte 3 | Byte 4 |
| :--- | :--- | :--- | :--- | :--- |
| **Plaintext** | `0000` | `0111` | `1100` | `0101` |
| **Pad ($\oplus$)** | `0011` | `1101` | `0001` | `1000` |
| **Cipher** | `0011` | `1010` | `1101` | `1101` |

---

## Asymmetric Encryption
### Private/Public Key Encryption: 1 Way
**Asymmetric:** different keys are used for coding and decoding. 

Here, there are no shared keys. Each end holds different keys. 

**Usage 1:** Private transmission of data
- The receiver can make K_1 public (encryption) but K_2 private (decryption)
- This allows people to privately send encrypted information.
- Can't be intercepted without K_2

**Usage 2:** Authentication
- If a sender keeps k_1 private but uses a public k_2, people can use k_2 to decrypt but only messages sent using K_1 will work, therefore, authenticating the send. 
---
### Private/Public Key Encryption: 2 Way
Like Whatsapp, both users create a pair of keys (private-public) and share their public keys via an open channel. 

User_1 encrypts first with private key and then with User_2's public key. 

User_2 decrypts with User_1's public key and then with their private key

This scheme achieves two goals at the same time: 
- **Privacy:** only User_2 can decrypt the message because only they have their private key. 
- **Authentication**: the fact that the message was successfully decoded using User_1’s public key authenticates that is coming from them
---
# Lab
No lab

---
# Readings

1. [[#Chapter 14 - Protection]]
2. [[#Chapter 15 Security]]
	1. [[#Cryptography as a Security Tool]]
	2. [[#Encryption]]
	3. [[#Symmetric Encryption_]]
	4. [[#Asymmetric Encryption_]]
	5. [[#Authentication_]]
	6. [[#Key Distribution]]
	7. [[#Summary]]
3. [[#Chapter 17 Distributed Systems]]
	1. [[#Resource Sharing]]
	2. [[#Computation Speedup]]
	3. [[#Reliability]]
	4. [[#Communication]]

## Chapter 14 - Protection
The processes in an operating system must be protected from one another’s activities. To provide such protection, we can use various mechanisms to ensure that only processes that have gained proper authorisation from the operating system can operate on the files, memory segments, CPU, and other resources of a system

Protection refers to a mechanism for controlling the access of programs, processes, or users to the resources defined by a computer system

Note that mechanisms are distinct from policies. Mechanisms determine how something will be done; policies decide what will be done.
- Policies are likely to change from place to place or time to time.
- Mechanisms should be generalised

The **principle of least privilege** dictates that programs, users, and even systems be given just enough privileges to perform their tasks.

A computer system is a collection of processes and objects. By objects, we mean both hardware objects (such as the CPU, memory segments, printers, disks, and tape drives) and software objects (such as files, programs, and semaphores).

A process should be allowed to access only those resources for which it has authorisation. Furthermore, at any time, a process should be able to access only those resources that it currently requires to complete its task (need-to-know principle).

A process operates within a protection domain, which specifies the resources that the process may access. Each domain defines a set of objects and the types of operations that may be invoked on each object

> Haven't take notes of, or particularly read, Access Matrix but if it comes up in the revision or past papers then review this. 



---
## Chapter 15 Security
"Protection" refers to internal problems. Security deals with the external environment which the system operates. 

A protection system is ineffective if user authentication is compromised or a program is run by an unauthorised user.

Computer resources must be guarded against unauthorised access, malicious destruction or alteration, and accidental introduction of inconsistency.

Security violations (or misuse) of the system can be categorised as intentional (malicious) or accidental.

---
## Cryptography as a Security Tool
In an isolated computer, the OS has access to complete information of its elements and hence can determine determine the sender and recipient of all interprocess communication.

In a network of computers, 
- a networked computer receives bits “from the wire” with no immediate and reliable way of determining what machine or application sent those bits. 
- A sending computer has no way of knowing who might eventually receive.
- Neither senders or receivers have any insight to eavesdroppers

IP addresses are commonly used as a identified for senders and recipients. However, this can easily be falsified. 

Abstractly, cryptography is used to constrain the potential senders and/or receivers of a message.
- It is build on secrets called keys which are distributed to computers in a network and used to process messages

Cryptography enables a recipient of a message to verify that the message was created by some computer possessing a certain key. 

Similarly, a sender can encode its message so that only a computer with a certain key can decode the message.

---
### Encryption
Used to send messages securely across across a network, as well as to protect database data, files from having their contents read by unauthorised entities.

An encryption algorithm enables the sender of a message to ensure that only a computer possessing a certain key can read the message, or ensure that the writer of data is the only reader of that data.

> Note, these statements are slightly misleading as they require a corresponding decryption algorithm. The statements are treating "encryption" as a catch-all term for the **entire cryptographic system**

> Strictly speaking, an encryption algorithm's only job is to hide the data; it is the **mathematical relationship between the encryption algorithm and its corresponding decryption algorithm** that guarantees only the holder of the specific key can ever read it again.

An encryption algorithm consists of the following components:
- A set K of keys. 
- A set M of messages. 
- A set C of ciphertexts.
- An encrypting function $E_k : K → (M → C)$
- A decrypting function $D_k : K → (C → M)$

An encryption algorithm must provide this essential property: given a ciphertext $c ∈ C$, a computer can compute m such that $E_k (m) = c$ only if it possesses $k$.

Thus, a computer holding $k$ can decrypt ciphertexts to the plaintexts used to produce them, but a computer not holding $k$ cannot decrypt ciphertexts.

Ciphertexts are expected to be exposed with reasons being that they themselves should not mean anything. Therefore, it is imperative, that the key cannot be back calculate from a ciphertexts, e.g. a intermediary ciphertexts where it is easy to to work out the input message and therefore compute the key. 

---
#### Symmetric Encryption_
In a symmetric encryption algorithm, the same key is used to encrypt and to decrypt.

Thus, the issue of protecting the key arises as by definition, the key designed to be distributed between senders and receivers. 

---
#### Asymmetric Encryption_
In an asymmetric encryption algorithm, there are different encryption and decryption keys.

An entity preparing to receive encrypted communication creates two keys and makes one of them (called the public key) available to anyone who wants it.

Any sender can use that key to encrypt a communication, but only the key creator can decrypt the communication.

This is known as public-key encryption.

It removes the need for any keys to be kept safe and secure. The public key is available for anyone that wants it and the private key never leaves the receivers computer. 

---
#### Authentication_
Above we looked at constraining the set of possible receivers of a message. Constraining the set of potential senders of a message is called authentication.
- Authentication is thus complementary to encryption.
- Authentication is also useful for proving that a message has not been modified.

An authentication algorithm using symmetric keys consists of the following components:
- A set K of keys.
- A set M of messages. 
- A set A of authenticators.
- A function $S : K → (M → A)$. That is, for each $k ∈ K, S_k$ is a function for generating authenticators from messages.
- A function $V : K → (M × A → {true, false})$. That is, for each $k ∈ K, V_k$ is a function for verifying authenticators on messages.

The critical property that an authentication algorithm must possess is this: for a message $m$, a computer can generate an authenticator $a ∈ A$ such that $V_k (m, a)= true$ only if it possesses $k$

a computer holding $k$ can generate authenticators on messages so that any computer possessing $k$ can verify them

> Note, this is a circular issue linking back to symmetric encryption. It requires the safe and secure distribution of the key. 

---
#### Key Distribution
A good part of the battle between cryptographers (those inventing ciphers) and cryptanalysts (those trying to break them) involves keys.

With symmetric algorithms, both parties need the key, and no one else should have it. The delivery of this key is a huge issue. 
- Such as issue that it may be distributed "out-of-band", meaning in person/offline.

Also, this current set up is pairwise. User needs N keys to communicate with N people. 

This is why Authorisation, like general encryption, turns to asymmetric algorithms. This means keys can be publicly exchanged and a user only needs to retain their private decryption key. 

Note, this public key option is not without negatives. It relies on a sender obtaining the true public key. The access point could be polluted, resulting in senders messages being intercepted, i.e. they have accidentally downloaded a hackers encryption and are sending it to a man-in-the-middle. 

This is where the use of Digital certificates which are digitally signed by trusted parties to verify the key itself. 

---
#### Summary
Encryption limits the domain of receivers of data, while authentication limits the domain of senders.

Encryption is used to provide confidentiality of data being stored or transferred.

Symmetric encryption requires a shared key, while asymmetric encryption provides a public key and a private key.

Authentication, when combined with hashing, can prove that data have not been changed.



---
## Chapter 17 Distributed Systems
A distributed system is a collection of processors that do not share memory or a clock. Each has its own local memory.

A distributed system is a collection of loosely coupled nodes interconnected by a communication network.

There are four major reasons for building distributed systems: 
- Resource sharing
- Computation speedup
- Reliability
- Communication.
### Resource Sharing
If a number of different sites (with different capabilities) are connected to one another, then a user at one site may be able to use the resources available at another (files, databases, specialised hardware)
### Computation Speedup
If a computation can be partitioned into subcomputations that can run concurrently, then a distributed system allows us to distribute the subcomputations among the various sites.

Or, if a single sited is overloaded with jobs in a queue, then it can be distributes across other less loaded sites. Movement of jobs is called load sharing. 
### Reliability
If one site fails in a distributed system, the remaining sites can continue operating, giving the system better reliability.

In general, with enough redundancy (in both hardware and data), the system can continue operation, even if some of its sites have failed.
### Communication
When several sites are connected to one another by a communication network, users at the various sites have the opportunity to exchange information.

Such functions include file transfer, login, mail, and remote procedure calls (RPCs).

The advantage of a distributed system is that these functions can be carried out over great distances. Two people at geographically distant sites can collaborate on a project, for example.

---

