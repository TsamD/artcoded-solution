class Script {
  get id() {
    return "92f0c3e6-ecc6-49b9-9043-4ca638462345";
  }
  get name() {
    return 'Log events';
  }
  get description() {
    return `A script to log each events received.`;
  }
  get enabled() {
    return true;
  }
  get consumeEvent() {
    return true;
  }
  process(payload) {
    let event = JSON.parse(payload);
    logger.info(`event of type ${event.eventName}, and version ${event.version} received.`);
    logger.info(payload);
    return "OK";
  }
}
