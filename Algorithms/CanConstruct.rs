fn can_construct(target: String, word_bank: Vec<String>) -> bool {
    let mut dp = vec![false; target.len() + 1];

    dp[0] = true;

    for i in 1..=target.len() {
        for word in &word_bank {
            if word.len() <= i && word == &target[i - word.len()..i] {
                dp[i] = dp[i - word.len()];
            }
        }
    }

    return dp[target.len()];
}

fn main() {
    println!("{}", can_construct("leetcode".to_string(), vec![String::from("leet"), String::from("code")]));
    println!("{}", can_construct("applepenapple".to_string(), vec![String::from("apple"), String::from("pen")]));
    println!("{}", can_construct("catsandog".to_string(), vec![String::from("cats"), String::from("dog"), String::from("sand"), String::from("and"), String::from("cat")]));
    println!("{}", can_construct("catsandog".to_string(), vec![String::from("cats"), String::from("dog"), String::from("sand"), String::from("and"), String::from("cat"), String::from("an")]));
    println!("{}", can_construct("skateboard".to_string(), vec![String::from("bo"), String::from("rd"), 
    String::from("ate"), String::from("t"), String::from("ska"), String::from("sk"), String::from("boar")]));
}