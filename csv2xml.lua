-- CSV-Dateien zu einer XML-Datei zusammenfassen

-- for debugging
function print_r(t, indent)
  indent = indent or 0
  local indentStr = string.rep(" ", indent)

  if type(t) == "table" then
    for k, v in pairs(t) do
      if type(v) == "table" then
        print(indentStr .. k .. ":")
        print_r(v, indent + 2)
      else
        print(indentStr .. k .. ": " .. tostring(v))
      end
    end
  else
    print(indentStr .. tostring(t))
  end
end

runtime = require("runtime")
csv = require("csv")
xml = require("xml")

local eingaben = runtime.variables.eingaben

mergedTabs = {}
for name in string.gmatch(eingaben, "[^,%s]+") do
  local filename = name .. ".csv"
  local csvTab, msg = csv.decode(filename, {separator = ";"})
  if not csvTab then
    print(msg)
    os.exit(-1)
  end

  -- The input root element
  csvTab._name = "table"

  -- Set attributes
  csvTab.name = name
  csvTab.title = runtime.variables["titel_" .. name] or
    name:gsub("_", " "):gsub("(%w)(%w*)", function(first, rest)
      return first:upper() .. rest:lower()
    end)

  for i=1,#csvTab do
    csvTab[i]._name = "row"
    for j=1,#csvTab[i] do
      local val = csvTab[i][j]
      csvTab[i][j] = { _name = "cell", val }
    end
  end

  table.insert(mergedTabs, csvTab)
end

-- The output root element
mergedTabs._name = "data"

-- Inject the current date in German format
local germanMonths = {
  "Januar", "Februar", "März", "April", "Mai", "Juni",
  "Juli", "August", "September", "Oktober", "November", "Dezember"
}

local currentDate = os.date("*t")
local germanFormattedDate =
  currentDate.day .. ". " ..
  germanMonths[currentDate.month] .. " " ..
  currentDate.year

mergedTabs["build-date"] = germanFormattedDate

-- Create a file named `data.xml`.
ok, err = xml.encode_table(mergedTabs)
if not ok then
  os.exit(-1)
end
