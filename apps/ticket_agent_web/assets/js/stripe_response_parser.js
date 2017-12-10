window.parse_stripe_response = function (response) {
  return {
    method_name: response.methodName,
    payer_email: response.payerEmail,
    payer_name: response.payerName,
    payer_phone: response.payerPhone,
    shipping_address: response.shippingAddress,
    shippingOption: response.shippingOption,
    token: window.parse_stripe_token_response(response.token)
  }
}

window.parse_stripe_token_response = function (token) {
  return {
    client_ip: token.client_ip,
    created: token.created,
    email: token.email,
    token_id: token.id,
    livemode: token.livemode,
    used: token.used,
    card: window.parse_stripe_card_response(token.card)
  }
}

window.parse_stripe_card_response = function (card) {
  return {
    city: card.address_city,
    country: card.address_country,
    line1: card.address_line1,
    line1_check: card.address_line1_check,
    line2: card.address_line2,
    state: card.address_state,
    zip: card.address_zip,
    zip_check: card.address_zip_check,
    card_type: card.brand,
    card_country: card.country,
    cvc_check: card.cvc_check,
    exp_month: card.exp_month,
    exp_year: card.exp_year,
    funding: card.funding,
    id: card.id,
    last4: card.last4,
    metadata: card.metadata,
    name: card.name
  }
}