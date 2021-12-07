# █   ██▀ █▀▄ ▄▀  ██▀ █▀▄
# █▄▄ █▄▄ █▄▀ ▀▄█ █▄▄ █▀▄

# Balance
bal() {
  ledger bal -f "$1" -VC
}

# Net Worth Balance
nw() {
  ledger bal -f "$1" -VC Assets or Liabilities or Reimbursement
}

# Expenses Balance
exp() {
  ledger bal -f "$1" -VC Expenses -p "this month"
}

# This Week Register
reg() {
  ledger reg -f "$1" -p "this week" --start-of-week monday
}

# Last Week Register
last-reg() {
  ledger reg -f "$1" -p "last week" --start-of-week monday
}
