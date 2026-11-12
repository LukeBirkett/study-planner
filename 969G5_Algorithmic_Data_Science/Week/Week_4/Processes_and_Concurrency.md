**_| [Canvas Page](https://canvas.sussex.ac.uk/courses/39278/pages/overview-and-reading-unit-4-2?module_item_id=1685501) | [Video Lecture](https://sussex.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=6a2f67f4-3677-41ff-b275-b4ec00c5cbd5) |_**
In this lecture, we will introduce the concept of a process, and show how this leads to the possibility of concurrent execution of multiple parts of a program simultaneously.

---
#### Learning Outcomes
- Describe context switching within an operating system
- Describe problems in building concurrent threads
---
## Background Reading
Operating System Concepts (9th) Silberschatz, Galvin and Gagne. ([1](https://github.com/TusharKukra/GateBooks/blob/master/(OS)%20Operating%20System%20Concepts%20(9th%20Ed)%20-%20Gagne%2C%20Silberschatz%2C%20and%20Galvin.pdf), [2](https://drive.uqu.edu.sa/_/mskhayat/files/MySubjects/2017SS%20Operating%20Systems/Abraham%20Silberschatz-Operating%20System%20Concepts%20(9th,2012_12).pdf))
- Chapter 1 - Introduction to basics of computer system architectures. 
- Chapter 3 - Processes.  
- Chapter 4 - Threads. 
- Chapter 5 - Scheduling. 
- Chapter 6 & 7 - Synchronisation.
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
## Chapter 1
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

