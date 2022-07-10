#include<iostream>

unsigned int number_of_set_bits(unsigned int a) {
    unsigned int count = 0;
    while(a) {
        count += a & 1;
        a >>= 1;
    }
    return count;
} 

unsigned int faster_sol(unsigned int a) {
    unsigned int count = 0;
    while(a) {
        a &= (a - 1);
        ++count;
    }
    return count;
}

int main() {
    unsigned int a;
    std::cin>>a;
    std::cout<<number_of_set_bits(a)<<std::endl;
    std::cout<<"Faster sol: "<<faster_sol(a)<<std::endl;
    return 0;
}