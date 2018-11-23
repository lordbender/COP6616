#include <iostream>
#include <thread> 

#include "main_cuda.cuh"

using namespace std; 

void foo(int Z) 
{ 
    for (int i = 0; i < Z; i++) { 
        cout << "Thread using function"
               " pointer as callable\n"; 
    } 
} 

class thread_obj { 
public: 
    void operator()(int x) 
    { 
        for (int i = 0; i < x; i++) 
            cout << "Thread using function"
                  " object as  callable\n"; 
    } 
}; 

double quicksort_cpu_pthreads(int size)
{   
    int *a = (int *)malloc(sizeof(int) * size);

    for (int i = 0; i < size; i++)
    {
        a[i] = rand();
    }

    clock_t start = clock();

    thread th1(foo, 3); 
    thread th2(thread_obj(), 3); 
  
    // Define a Lambda Expression 
    auto f = [](int x) { 
        for (int i = 0; i < x; i++) 
            cout << "Thread using lambda"
             " expression as callable\n"; 
    }; 
  
    thread th3(f, 3); 
  
    th1.join(); 
    th2.join(); 
    th3.join();
    
    clock_t end = clock();

    // Testing that sort is working, keep commented out on large values of N (say N > 1000)
    // for (int i = 0; i < size; i++)
    // {
    //     printf("\t %d\n", a[i]);
    // }

    return time_calc(start, end);
}
