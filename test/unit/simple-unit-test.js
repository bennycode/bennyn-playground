describe("Simple Test setup test", function() {

  it("loads jQuery", function() {
    expect(jQuery.fn.jquery).toEqual("2.1.0");
  });

});