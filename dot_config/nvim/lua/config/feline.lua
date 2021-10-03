-- Initialize the components table
local components = { active = {}, inactive = {} }

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

-- Insert a component that will be on the right side of the statusline
-- when the window is active:
table.insert(components.active[1], {
	-- Component info here
})

require("feline").setup({ components = components })
