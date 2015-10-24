FALSE_VALUES = [nil, false, "", 0, "0", "false", "no"]

# this method can use in view, model, controller, helper...
def false?(v)
  FALSE_VALUES.include?(v)
end
