Algo Week 4 Notes

CPU is where computation takes place on a PC

Core = CPU

Can and do have multiple

Within a CPU core:
 - Control Unit: flow of data
 - Arithmetic Logic Unit: does maths on binary numbers
 - Registers: quickest access data. intermetidate results. small
 - Cache Memory: optimisation, high speed access. frequently used data
 - Kernel Memory: operting system stuff


register > cache > main memory > solid state disk > magnetic disk

left to right in terms of size

left to right in terms of stable 

less stable dispears on restart

more stable is slower to undpate

#### Parallelish vs Concurrency

P: walking and thinking at the same time. Uses different resources to acheive each output

C: Eating and talking at the same time. Actions that use that same resources

C make it look like two things are happening it once but actually it is very quickly switching between the two

Parallelism is the ability of a multi-core CPU

Concurrency is the ability of a single CPU

#### Proccess

This is a unit of work

Distinct from a programe as a programme can hold mutli processes

The process is the actual execution of a set of intrucitons after being loaded from the disk into memory

The instructions are in the CPU. Not just in the hard drive

Could be whole programme, or a chunk of a programme where they are more complicated

 
## Threads

Processes sharing resources

Processes have mutliple threads

A thread is lightweight process


