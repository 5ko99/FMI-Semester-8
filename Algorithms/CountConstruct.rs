fn count_construct(target: String, word_bank: Vec<String>) -> i32 {
    let mut dp = vec![0; target.len() + 1];

    dp[0] = 1;

    for i in 1..=target.len() {
        for word in &word_bank {
            if word.len() <= i && word == &target[i - word.len()..i] {
                dp[i] += dp[i - word.len()];
            }
        }
    }

    return dp[target.len()];
}

fn main() {
    println!("{}", count_construct("leetcode".to_string(), vec![String::from("leet"), String::from("code")]));
    println!("{}", count_construct("applepenapple".to_string(), vec![String::from("apple"), String::from("pen")]));
    println!("{}", count_construct("catsandog".to_string(), vec![String::from("cats"), String::from("dog"), String::from("sand"), String::from("and"), String::from("cat")]));
    println!("{}", count_construct("catsandog".to_string(), vec![String::from("cats"), String::from("dog"), String::from("sand"), String::from("and"), String::from("cat"), String::from("an")]));
    println!("{}", count_construct("skateboard".to_string(), vec![String::from("bo"), String::from("rd"), 
    String::from("ate"), String::from("t"), String::from("ska"), String::from("sk"), String::from("boar")]));
    println!("{}", count_construct("abcdef".to_string(), vec![String::from("ab"), String::from("cd"), String::from("ef"), String::from("abc"), 
    String::from("def"), String::from("d"), String::from("ef"), String::from("abcdef"), String::from("abcd")]));
    println!("{}", count_construct("leetcode".to_string(), vec![String::from("leet"), String::from("code"), String::from("leetcode"), String::from("leetcod"), String::from("e")]));
}