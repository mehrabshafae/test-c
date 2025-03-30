#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

// fn head(int argc, char *argv[]);
void run();
void init() __attribute__((constructor));
void end() __attribute__((destructor));

void exitOne() {
    printf("atexit\n");
 }


static void critical(void (*func)(void)) {
    #pragma omp critical
        {
            func();
        }
}

void task(void (*func)(void)) {
    #pragma omp task
        {
            func();
        }
}

void taskgroup(void (*func)(void)) {
    #pragma omp parallel
            {
    #pragma omp single
                {
    #pragma omp taskgroup
                    {
                        task(func);
                    }
                }
            }
}

int main(const int argc, char *argv[]) {
    printf("Hi\n");
    atexit(exitOne);
    // exit(0); // safer exit
    // _exit(0); // force exit, ignores end/atexit functions

    taskgroup(run);
    printf("Total arguments: %d\n", argc);
    
    for (int i = 0; i < argc; i++) {
        printf("argv[%d] = %s\n", i, argv[i]);
    }
    return 0;
}

void init(){
    printf("init\n");
    omp_set_dynamic(0);
    omp_set_num_threads(omp_get_num_procs());
    omp_set_nested(1);
}

void end(){
    printf("end\n");
    #pragma omp taskwait
}

void run1(){
    printf("run1 func\n");
}
void run2(){
    printf("run2 func\n");
}
void run(){
    printf("run func\n");
    task(run1);
    task(run2);
}
