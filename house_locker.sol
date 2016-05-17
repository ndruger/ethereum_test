contract HouseLocker {
  uint constant unit_term = 30;
  uint constant price = 8 szabo;

  address owner;
  address tenantUser;

  uint lastPaidTime;

  function HouseLocker() {
    owner = msg.sender;
  }

  function pay() {
    if (msg.value < price) {
      msg.sender.send(msg.value);
      return;
    }

    tenantUser = msg.sender;
    lastPaidTime = block.timestamp;

    owner.send(msg.value);
  }

  function verifyAndUpdateTenantUser() {
    if (block.timestamp - lastPaidTime > unit_term) {
      tenantUser = 0;
    }
  }

  function getTenantUser() constant returns(address user) {
    return tenantUser;
  }
}
