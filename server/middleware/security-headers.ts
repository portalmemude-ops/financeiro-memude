export default defineEventHandler(event => {
  setResponseHeaders(event, {
    'Content-Security-Policy': 'base-uri \'self\'; frame-ancestors \'none\'; object-src \'none\'',
    'Cross-Origin-Opener-Policy': 'same-origin',
    'Permissions-Policy': 'camera=(), microphone=(), geolocation=(), payment=()',
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
  })

  if (process.env.NODE_ENV === 'production')
    setResponseHeader(event, 'Strict-Transport-Security', 'max-age=31536000; includeSubDomains')
})
