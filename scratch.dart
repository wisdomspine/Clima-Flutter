void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2Data = await task2();
  task3(task2Data);
}

void task1() {
  print('Task 1 complete');
}

Future<String> task2() {
  Duration duration = Duration(seconds: 10);
  return Future.delayed(duration, () {
    String result = 'task 2 data';
    print("task 2 complete");
    return result;
  });
}

void task3(String task2Data) {
  print("task2 completed with $task2Data");
  print('Task 3 complete');
}
