contract Counter {
  uint count;

  function get() constant returns (uint current) {
    return count;
  }

  function increment() {
    count++;
  }

  function reset() {
    count = 0;
  }
}
