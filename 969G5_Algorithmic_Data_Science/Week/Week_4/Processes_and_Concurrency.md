**_| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/pages/overview-and-reading-unit-4-2?module_item_id=1685501) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=6a2f67f4-3677-41ff-b275-b4ec00c5cbd5) |_**
In this lecture, we will introduce the concept of a process, and show how this leads to the possibility of concurrent execution of multiple parts of a program simultaneously.

---
#### Learning Outcomes
- Describe context switching within an operating system
- Describe problems in building concurrent threads
---
## Background Reading
Operating System Concepts (9th) Silberschatz, Galvin and Gagne. ([1](https://github.com/TusharKukra/GateBooks/blob/master/(OS)%20Operating%20System%20Concepts%20(9th%20Ed)%20-%20Gagne%2C%20Silberschatz%2C%20and%20Galvin.pdf), [2](https://drive.uqu.edu.sa/_/mskhayat/files/MySubjects/2017SS%20Operating%20Systems/Abraham%20Silberschatz-Operating%20System%20Concepts%20(9th,2012_12).pdf))
- [x] Chapter 1 - Introduction to basics of computer system architectures. 
- [x] Chapter 3 - Processes.  
- [x] Chapter 4 - Threads. 
- [ ] Chapter 5 - Scheduling. 
- [ ]  Chapter 6 & 7 - Synchronisation.
---
# Lecture
- **_| [[Lecture4.pdf]] |_**
---
Anatomy of a Processor
- Compile slides + speech
---
Central Processing Unit (CPU) Cores
- **TODO:** Compile slides + speech
- Make this section minimal
- + Table
---
Parallelism vs Concurrency
- Parallelism two CPU cores doing more than one thing at the same time. 
	- Get definition from slide
- Concurrency is alternating between doing multiple things. Not strictly doing them at the same time but possibly giving the impression of doing so. 
	- Get definition from slide
	- Cannot physically run two lines of code at the same time. 
---
The idea of a process
- A process is an abstraction which represents what is needed to run a single program
- It is the execution of the programmes instructions
- Run programme, process executes, output. 
- Programme holds a bunch of info:
	- Programme to run
	- Position in the execution sequence 
	- Status of all registers
	- Portion of memory allocated
	- Ad-hoc allocations and security attributes
---
Where do processes come from? 
- Most Operating Systems (OS) provide a process management module which can create, run and terminal processes. 
- Users make requests to this module using system calls.
- Process as what makes a system call. 
- This means processes are created by other processes.
---
The Process Control Block
- PCV is the data structure that contains all the process information
- **TODO:** get info from graph + speech notes
---
Elements of the PCB
- The pointer is used to link processes together to form queues.
- TODO: speech notes + rest of slide notes
---
Process management — Creation
- Initial process (at least one) on PC/OS turning on. 
- Processes create more processes
- Child inherits some or all of parents resources, i.e. CPU becomes distributed across processes.
- Two modes
	- Parent and child run concurrently
	- Parents waits for child to terminate
---
Process Queues
- TODO: collect info on different types of queues
---
Process Management - Scheduling
- Scheduling of processes is done via a number of instances.
- TODO: notes of short term vs long term. 
- Processes can be
	- I/O bound - perform a lot of input/output
	- CPU bound - perform a lot of computation
- A good scheduler chooses a suitable mix of the two
---
Context Switch
- How does the scheduler allocate the CPU to a new process in the ready queue
- Allocate resources to manage the reallocation of resrouces between processes. 
- Regarding how to stop CPU allocation from one process to another 
- Called "context switching"
- TODO: slides and speech to get better notes
---
Process management — Termination
- 1. Could terminal itself by executing a terminal system call
- 2. Parent may terminal child process (think about force quitting)
- Complexities need to be considered when a parent is terminated
	- Child also terminated, known as cascading termination
	- Another parent is allocated to the child (grandparent, init)
---
Process State Transitions
- Graphic
- TOOD: Speech lecture explained what we should be remembering the regarding this entire block
---
The Need for Threads: 
- Thread is like a sub-process
- Think about a complicated task involving many roles i.e. word processor. 
- Receives input, renders images, calculating, perform spell check. 
- A single sequence of instructions is inefficient and difficult to programme. 
- Another option is to have multiple small processes each performing one of these roles with an OS system sequencing them concurrently. 
- However, these programmes should be grouped together some how. 
---
The Thread Concept
 - A thread is a lightweight process
 - Process are allow to have multiple threads. 
 - It has its own; identifier; register set; program counter; execution set
 - However in terms of grouping, it shares; code, data and resources with other threads. 
 - Some process has multithreads, others single
 - BUT, only one thread can still run at a time in the CPU, so it is still just concurrency but more intertwined by sharing resources
---
 Coordinating Process - Concurrency
 - Producer offers something in shared buffer (stock), a consumer takes them out. 
 - There needs to be synchronisation between processes for the buffer to suffice
---
Critical Section problem — constraints
- TODO: slide of definition
- Also compile speech notes from this slide and the previous
---
Synchronisation Tool 1: Lock
- "Synchronisation" is the jargon for making sure things run smoothly
- A lock is a variable which an be free or held
- When it is free, a thread attempting to get the lock will hold it. 
- It is shared resource
- Threads can only run, or access certain resources with a lock, therefore, other threads need join a queue to get the lock. 
---
# Lab


---
# Readings

1. [[#Chapter 1 - Introduction]]
2. [[#Chapter 3 - Processes]]
3. [[#Chapter 4 - Threads]]

---
## Chapter 1 - Introduction
### What are the three main purposes of an operating system?
1. **To provide an environment for a computer user to execute programs** on computer hardware in a convenient and efficient manner.
2. **To allocate the separate resources of the computer** (such as CPU time, memory space, file-storage space, and I/O devices) as needed to solve the problem given. The allocation process should be as fair and efficient as possible.
3. **As a control program**, it serves two major functions:
	- **Supervision of the execution of user programs** to prevent errors and improper use of the computer.
	- **Management of the operation and control of I/O devices.**

> **I/O** stands for **Input/Output**. An **I/O device** is a piece of hardware that lets the core brain of the computer (CPU and main memory) communicate with the outside world (human user, a storage drive, or another computer over a network). Without I/O devices, a CPU would just be doing math in a locked box with no way to receive instructions or show you the results.
> 
> There are various types of I/O devices:
> 
> **Input Devices (Data In):** Hardware that sends information _into_ the computer. Examples: keyboard, mouse, microphone, webcam, touchscreen.
> 
> **Output Devices (Data Out):** Hardware that takes processed information _out_ of the computer so you can perceive it. Examples: monitor, speakers, printer.
> 
> **Two-Way / Storage & Communication Devices (Both In & Out):** Hardware that both sends and receives data. In an OS textbook, **hard drives, SSDs, USB flash drives, and network cards (Wi-Fi/Ethernet)** are all treated as I/O devices because the CPU has to read data _in_ from them and write data _out_ to them.




---
## Chapter 3 - Processes

Early computers only executed one program at a time, encompassing all resources. Modern computers load multiple programs into memory and execute concurrently. This evolution required more compartmentalisation leading to the notion of a process, **which is a program in execution.**

A process is the unit of work in a modern time-sharing system. It forms the basis of all computation. 

A process encompasses all a computer activity. It is easy to think about user programs, like word process or a browser, but an operating system has its own internal programmed activities such as memory management. 

A process is more than just the program code, it is also things like the current activity and contents of the register. A process stack to hold temporary data (function param, local vars). A data section containing global variables. 

A program itself is to a process, it is passive entity containing instructions stored on a disk. A process is an active entity instructed by the program. A program becomes a process when an executable file is loaded into memory. 

Processes have a state which is defined in part by the current activity of that process: 
- **New**. The process is being created.
- **Running**. Instructions are being executed.
- **Waiting**. The process is waiting for some event to occur (such as an I/O completion or reception of a signal).
- **Ready**. The process is waiting to be assigned to a processor.
- **Terminated**. The process has finished execution.

This single thread of control allows the process to perform only one task at a time. A user could not type and run spell check within the same process and therefore cannot do both simultaneously. 

Most modern operating systems have extended the process concept to allow a process to have multiple threads of execution and thus to perform more than one task at a time. 

As processes enter the system, they are put into a **job queue,** which consists of all processes in the system. The processes that are residing in main memory and are ready and waiting to execute are kept on a list called the ready queue. This queue is generally stored as a linked list. 

A ready-queue header contains pointers to the first and final PCBs in the list. Each PCB includes a pointer field that points to the next PCB in the ready queue.

There are many types of types. Suppose a process makes an an I/O request to a shared device which is busy. The process therefore may have to wait for the disk. The list of processes waiting for a particular I/O device is called a device queue. Each device has its own device queue. 

During the course of execution, a process may create several new processes. As mentioned earlier, the creating process is called a parent process, and the new processes are called the children of that process. Each of these new processes may in turn create other processes, forming a tree of processes.
- The init process (which always has a pid of 1) serves as the root parent process for all user processes.

In general, when a process creates a child process, that child process will need certain resources (CPU time, memory, files, I/O devices) to accomplish its task. A child process may be able to obtain its resources directly from the operating system, or it may be constrained to a subset of the resources of the parent process.

When a process creates a new process, two possibilities for execution exist:
1. The parent continues to execute concurrently with its children.
2. The parent waits until some or all of its children have terminated.

There are also two address-space possibilities for the new process:
1. The child process is a duplicate of the parent process (it has the same program and data as the parent).
2. The child process has a new program loaded into it.

A process terminates when it finishes executing its final statement and asks the operating system to delete it by using the exit() system call. At that point, the process may return a status value (typically an integer) to its parent process (via the wait() system call). All the resources of the process—including physical and virtual memory, open files, and I/O buffers—are deallocated by the operating system.

A parent may terminate the execution of one of its children for a variety of reasons, such as these:
- The child has exceeded its usage of some of the resources that it has been allocated.
- The task assigned to the child is no longer required.
- The parent is exiting, and the operating system does not allow a child to continue if its parent terminates.

Processes executing concurrently in the operating system may be either independent processes or cooperating processes. 
- A process is independent if it cannot affect or be affected by the other processes executing in the system. Any process that does not share data with any other process is independent.
- A process is cooperating if it can affect or be affected by the other processes executing in the system. "Sharing" always falls under cooperating. 




---
## Chapter 4 - Threads
Chapter 3 assumed a process that executing a program with a single thread of control. Modern OS contain multiple threads of control. 

The notion of a thread—a fundamental unit of CPU utilisation that forms the basis of multithreaded computer systems.

A thread is a basic unit of CPU utilisation.
- it comprises a thread ID, a program counter, a register set, and a stack.

Threads exist under a process and therefore share the code section, data section and OS resources (e.g. files). Each thread maintains its own register and stack. 

A traditional (or heavyweight) process has a single thread of control. If a process has multiple threads of control, it can perform more than one task at a time.

Processes can only share resources through techniques such as shared memory and message passing. Such techniques must be explicitly arranged by the programmer. However, threads share the memory and the resources of the process to which they belong by default.

Allocating memory and resources for process creation is costly. Because threads share the resources of the process to which they belong, it is more economical to create and context-switch threads.

Note, that strictly speaking, cores and CPU are not the same. A CPU (Central Processing Unit/Processor is the physical chip. A core is an individual processing engine _inside_ that CPU chip. A core has its own set of registers, Arithmetic Logic Unit (ALU), and control unit, allowing it to independently fetch and execute instructions.
- However, historically, a single-core CPU meant 1 CPU chip = 1 core, meaning were the "same" thing. 
- Modern computers are multi-core CPU's (e.g., a 4-core or 8-core processor). Given 1 physical CPU, the operating system sees **4 or 8 separate logical CPUs** that can run different processes or threads at the exact same time.

Multithreaded programming provides a mechanism for more efficient use of these multiple computing cores and improved concurrency. On a system with multiple cores, however, concurrency means that the threads can run in parallel, because the system can assign a separate thread to each core.

A system is parallel if it can perform more than one task simultaneously. In contrast, a concurrent system supports more than one task by allowing all the tasks to make progress.
- Prior to multi-core architectures, single processor computers were designed to provide the illusion of parallelism by rapidly switching between processes. Such processes were running concurrently, but not in parallel.

In general, there are two types of parallelism: data parallelism and task parallelism.
- Data P, focuses on distributing subsets of the same data across cores, performing the same operation. Think about summing the elements of an array but splitting the array into $N$ parts and computing in parallel.
- Task P, involves allocating a unique task to different cores. 

> In _Operating System Concepts_, Silberschatz gives a crisp one-line definition of the **kernel**: it is **"the one program running at all times on the computer."**
>
>Everything else on your machine—your web browser, Spotify, the desktop wallpaper, even the file explorer—is either a **system program** or an **application program** that starts, runs, and closes. The kernel is the permanent core of the operating system that loads into memory when you turn on the computer and stays there until you shut it down.

Threads can have different types: 
- Support for threads may be provided either at the user level, for user threads
- or by the kernel, for kernel threads.

User threads are supported above the kernel and are managed without kernel support, whereas kernel threads are supported and managed directly by the operating system.

---

> **Provide two programming examples in which multithreading provides better performance than a single-threaded solution.**
>
> **A Multi-Threaded Web Server (I/O-Bound):** When handling multiple incoming client requests that require slow disk reads or database queries, a single-threaded server blocks all other users while waiting for I/O to complete. A multi-threaded server spawns a separate thread per request, allowing the CPU to switch to other active threads while one is blocked on I/O, significantly increasing throughput and responsiveness.
> 
> **I/O is traditionally vastly slower than the CPU and main memory (RAM)**, often by several orders of magnitude. This gap is known in computer architecture as the **I/O bottleneck**. Traditional I/O devices—like spinning hard disk drives (HDDs), printers, optical drives, and network cables—rely on **physical mechanical movement** (spinning platters, moving read/write heads) or **human interaction** (typing on a keyboard), which operate in **milliseconds** rather than nanoseconds.
>
> **Matrix Multiplication or Image Processing (CPU-Bound):** Dividing a large matrix multiplication or pixel-filtering task into independent chunks allows multiple threads to execute **in parallel** across different cores of a multi-core processor. A single-threaded solution can only utilize one core at a time, whereas a multi-threaded solution completes the computation in a fraction of the time.

---

> **Provide two programming examples in which multithreading does not provide better performance than a single-threaded solution.**
> 
> 1. **Inherently Sequential Tasks (Data Dependencies):**
>    Evaluating a recurrence relation where step $n$ depends directly on the result of step $n-1$. Each forward step must wait for the previous to finish, threads cannot execute in parallel. Using multiple threads only adds creation, synchronisation, and context-switching overhead without speeding up execution.
>
> 2. **Fine-Grained Locking/High Contention on a Shared Resource:**
> 	Multiple threads simultaneously incrementing a single shared counter or inserting items into a single locked hash table/queue in a tight loop. Every thread must acquire the same mutex lock to safely update the shared data, threads spend most of their time blocked waiting for the lock rather than computing. The overhead of lock acquisition, cache invalidation, and thread contention makes the multi-threaded program run **slower** than a simple single-threaded loop.
> 
> **3. Small workloads:**
> Such as sorting a 20-element array—the time spent creating and joining threads far exceeds the microseconds needed for a single thread to finish the task.

---

> **Which of the following components of program state are shared across threads in a multithreaded process? a. Register values b. Heap memory c. Global variables d. Stack memory**
> 
> Shared: 
> - **Heap memory:** Dynamically allocated memory lives in the process's shared address space. 
> - **Global variables:** Static and global variables reside in the shared data segment and are accessible to every thread in the process (along with code/instructions and open files).
> 
> Private:
> - **Register values:** Each thread executes independently and tracks its own program counter and CPU registers.
> - **Stack memory:** Each thread maintains its own call stack to store local variables, function parameters, and return addresses without interfering with other threads' function calls.

---

- **Register values:** Ultra-fast storage slots inside the CPU holding the active data and current instruction address for a single thread.
    
- **Stack memory:** A private, last-in-first-out (LIFO) memory (Also RAM) region that tracks a thread's active function calls and local variables. Destroys memory ad-hoc, e.g. after function returns. Small data only, fast access. 
    
- **Heap memory:** A large, shared pool of RAM used for dynamically allocated objects and data that persist until freed.
    
- **Global variables:** Variables declared outside all functions in a shared data segment, accessible to every thread for the program's entire lifetime.

---

> **Is it possible to have concurrency but not parallelism? Explain.**
> 
> Concurrency without parallelism occurs whenever multiple tasks make progress over overlapping time periods by taking turns on a **single processing core**, rather than executing at the exact same physical instant.
> 
> **Concurrency (Dealing with multiple things at once):** Refers to program structure and scheduling where multiple tasks or threads are in progress simultaneously. On a **single-core CPU**, the operating system achieves concurrency through **time-slicing (rapid context switching)**—running Thread A for a few milliseconds, switching to Thread B, then Thread C, and back to Thread A. Because these switches happen thousands of times per second, all tasks advance together and appear to run simultaneously to the user.
> 
> **Parallelism (Doing multiple things at once):** Requires **multiple physical cores or processors** executing separate instruction streams at the **exact same instant in time**.

---