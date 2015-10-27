json.product do
  json.id @product.id
  json.name @product.name
  json.desc @product.desc
  json.abbr @product.abbr
  json.currency @product.currency if @product.currency
  json.amount @product.amount if @product.amount
  json.period @product.period if @product.period
  json.paid @product.paid if @product.paid
  json.sales_period @product.sales_period if @product.sales_period
  json.block_period @product.block_period if @product.block_period
  json.redeem @product.redeem if @product.redeem
  json.entity @product.entity if @product.entity
  json.adviser @product.adviser if @product.adviser
  json.trustee @product.trustee if @product.trustee
  json.reg_organ @product.reg_organ if @product.reg_organ
  json.website @product.website if @product.website
  json.agency @product.agency if @product.agency
  json.regulatory_filing @product.regulatory_filing if @product.regulatory_filing
  json.legal_consultant @product.legal_consultant if @product.legal_consultant
  json.audit @product.audit if @product.audit
  json.rate @product.rate if @product.rate
  json.account @product.account if @product.account
  json.progress @product.progress if @product.progress
  json.direction @product.direction if @product.direction
  json.risk_control @product.risk_control if @product.risk_control
  json.instruction @product.instruction if @product.instruction
  json.agreement @product.agreement if @product.agreement
  json.condition @product.condition if @product.condition
  json.rois do
    json.array!(@product.rois) do |roi|
      json.(roi, :id, :range, :profit)
    end
  end
end