-- CSV-Dateien zu einer XML-Datei zusammenfassen

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

mergedtabs = {}
for name in string.gmatch(runtime.variables.eingaben, "[^,%s]+") do
  local filename = name .. ".csv"
  local csvtab, msg = csv.decode(filename, {separator = ";"})
  if not csvtab then
      print(msg)
      os.exit(-1)
  end

  -- The input root element
  csvtab._name = "table"

  -- Set attributes
  csvtab.name = name
  csvtab.title = runtime.variables["title_" .. name] or
    name:gsub("_", " "):gsub("(%w)([%w_']*)", function(first, rest)
      return first:upper() .. rest:lower()
    end)

  for i=1,#csvtab do
      -- level 1
      csvtab[i]._name = "row"
      for j=1,#csvtab[i] do
        -- level 2
        local val = csvtab[i][j]
        csvtab[i][j] = { _name = "cell", val }
      end
  end

  table.insert(mergedtabs, csvtab)
end

-- The output root element
mergedtabs._name = "data"

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

mergedtabs["build-date"] = germanFormattedDate

-- Create a file named `data.xml`.
ok, err = xml.encode_table(mergedtabs)
if not ok then
    os.exit(-1)
end
