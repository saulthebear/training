/*
You need to check all the usernames in a database.
Here are some simple rules that users have to follow when creating their
username.

1. Usernames can only use alpha-numeric characters.

2. The only numbers in the username have to be at the end.
There can be zero or more of them at the end. Username cannot start with
the number.

3. Username letters can be lowercase and uppercase.

4. Usernames have to be at least two characters long. A two-character username
can only use alphabet letters as characters.
*/

let username = "JackOfAllTrades";
let userCheck = /^[a-zA-Z][a-zA-Z]+[0-9]*$|^[a-zA-Z][0-9]{2,}$/;
let result = userCheck.test(username);