## Homework
[![Coverage Status](https://coveralls.io/repos/github/beq286/TP-lab05/badge.svg?branch=main)](https://coveralls.io/github/beq286/TP-lab05?branch=main)
### Задание
1. Создайте `CMakeList.txt` для библиотеки *banking*.
2. Создайте модульные тесты на классы `Transaction` и `Account`.
    * Используйте mock-объекты.
    * Покрытие кода должно составлять 100%.
3. Настройте сборочную процедуру на **TravisCI**.
4. Настройте [Coveralls.io](https://coveralls.io/).
### Создаем
```
$ mkdir third-party
$ git submodule add https://github.com/google/googletest third-party/gtest
$ touch CMakeLists.txt
$ mkdir .coverage
$ touch lcov.info
$ mkdir tests
$ cd tests
$ touch test_Account.cpp
$ touch test_Transaction.cpp
$ mkdir .github/workflows
$ cd .github/workflows
$ touch actions.yml
```
### test_Account.cpp
```
#include <Account.h>
#include <gtest/gtest.h>

TEST(Account, Banking){
	Account test(0,0);
	
	ASSERT_EQ(test.GetBalance(), 0);
	
	ASSERT_THROW(test.ChangeBalance(100), std::runtime_error);
	
	test.Lock();
	
	ASSERT_NO_THROW(test.ChangeBalance(100));
	
	ASSERT_EQ(test.GetBalance(), 100);

	ASSERT_THROW(test.Lock(), std::runtime_error);

	test.Unlock();
	ASSERT_THROW(test.ChangeBalance(100), std::runtime_error);
}
```
### test_Transaction.cpp
```
#include <Account.h>
#include <Transaction.h>
#include <gtest/gtest.h>

TEST(Transaction, Banking) {
    const int initial_balance_Alice = 10000;
    const int initial_balance_Bob = 2000;
    const int transaction_fee = 50;

    Account Alice(0, initial_balance_Alice), Bob(1, initial_balance_Bob);
    Transaction test_tran;

    ASSERT_EQ(test_tran.fee(), 1);
    test_tran.set_fee(transaction_fee);
    ASSERT_EQ(test_tran.fee(), transaction_fee);

    ASSERT_THROW(test_tran.Make(Alice, Alice, 2000), std::logic_error);
    ASSERT_THROW(test_tran.Make(Alice, Bob, -100), std::invalid_argument);
    ASSERT_THROW(test_tran.Make(Alice, Bob, 50), std::logic_error);

    if (test_tran.fee() * 2 - 1 >= 200) {
        ASSERT_FALSE(test_tran.Make(Alice, Bob, test_tran.fee() * 2 - 1));
    }

    Alice.Lock();
    ASSERT_THROW(test_tran.Make(Alice, Bob, 2000), std::runtime_error);
    Alice.Unlock();

    ASSERT_TRUE(test_tran.Make(Alice, Bob, 2000));
    ASSERT_EQ(Bob.GetBalance(), initial_balance_Bob + 2000);	
    ASSERT_EQ(Alice.GetBalance(), initial_balance_Alice - 2000 - transaction_fee);

    ASSERT_FALSE(test_tran.Make(Alice, Bob, 8000));
    ASSERT_EQ(Bob.GetBalance(), initial_balance_Bob + 2000);	
    ASSERT_EQ(Alice.GetBalance(), initial_balance_Alice - 2000 - transaction_fee);
}

```

## Links

- [C++ CI: Travis, CMake, GTest, Coveralls & Appveyor](http://david-grs.github.io/cpp-clang-travis-cmake-gtest-coveralls-appveyor/)
- [Boost.Tests](http://www.boost.org/doc/libs/1_63_0/libs/test/doc/html/)
- [Catch](https://github.com/catchorg/Catch2)

```
Copyright (c) 2015-2021 The ISC Authors
```
