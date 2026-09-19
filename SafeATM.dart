void checkBalance({required String name, required double balance}) =>
    print("Name: $name \nBalance: $balance \n -------");

double deposit(double currentBalance, double? amount) {
    amount ??= 0.0;
    currentBalance += amount;
    print("Deposit: $amount \nnew balance: $currentBalance \n-------");
    return currentBalance;
}

double withdraw(
    String name,
    double currentBalance,
    double? amount,
    int? pincode,
) {
    pincode ??= 0000;
    if (pincode != 1234) {
    print("Incorrect pincode");
    return currentBalance;
    }
    amount ??= 0.0;
    if (amount > currentBalance) {
    print('Insufficient balance');
    return currentBalance;
    }
    currentBalance -= amount;
    print("Withdraw: $amount \nnew balance: $currentBalance \n-------");
    return currentBalance;
}

void main() {
    double balance = 1000.0;
    checkBalance(name: "Nurda", balance: balance);
    balance = deposit(balance, 500.0);
    checkBalance(name: "Nurda", balance: balance);
    balance = withdraw("Nurda", balance, 200.0, 1234);
    checkBalance(name: "Nurda", balance: balance);
}