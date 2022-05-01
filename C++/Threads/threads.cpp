#include<iostream>
#include<thread>
#include<chrono>

static bool finished = false;

void do_work() {
    while(!finished) {
        std::cout << "working...\n";
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }
}

int main() {
    
    std::thread worker(do_work);

    std::cin.get();
    finished = true;

    worker.join();
    std::cout<<"finished\n";

    return 0;
}