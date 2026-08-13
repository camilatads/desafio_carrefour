describe('Example Test Suite', () => {
  it('should load the page', () => {
    cy.visit('https://example.com')
    cy.title().should('include', 'Example Domain')
  })
})
