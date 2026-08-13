function fn() {
  var config = {
    baseUrl: 'https://serverest.dev',
    authUrl: 'https://serverest.dev/login',
    token: null,
    rateLimitDelay: 600, // 600ms between requests to respect 100 req/min limit
    outputDir: 'target/karate-reports'
  };
  return config;
}
