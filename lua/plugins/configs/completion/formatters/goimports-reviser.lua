local company_prefixes = os.getenv("COMPANY_PREFIXES")
if company_prefixes then
	return { "-company-prefixes=" .. company_prefixes }
else
	return {}
end
-- -rm-unused
