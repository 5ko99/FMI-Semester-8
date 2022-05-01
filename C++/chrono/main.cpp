#include<iostream>
#include<thread>
#include<chrono>

struct Timer {

    std::chrono::time_point<std::chrono::high_resolution_clock> start,end;
    std::chrono::duration<double> duration;

    Timer() {
        start = std::chrono::high_resolution_clock::now();
    }

    ~Timer() {
        end = std::chrono::high_resolution_clock::now();
        duration = end - start;

        float ms = duration.count() * 1000.0;
        std::cout<< "Timer took:" << ms << " ms\n";
    }
};

void f() {
    Timer timer;
    for(int i=0; i<1090; ++i) {
        printf("Running...\n");
    }
}

int main() {
    using namespace std::literals::chrono_literals;

    auto start = std::chrono::high_resolution_clock::now();

    std::this_thread::sleep_for(1s);

    auto end = std::chrono::high_resolution_clock::now();

    std::chrono::duration<double> duration = end - start;

    std::cout<<"duration: "<<duration.count()<<'s'<<"\n";

    f();

    return 0;
}