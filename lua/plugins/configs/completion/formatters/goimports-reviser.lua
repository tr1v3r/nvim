local company_prefixes = os.getenv("COMPANY_PREFIXES")
if company_prefixes then
	return { "-rm-unused", "-company-prefixes", company_prefixes }
else
	return { "-rm-unused" }
end
