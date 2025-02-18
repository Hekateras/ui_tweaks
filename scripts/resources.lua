local resources = include("resources")

local function initUitrResources()
    -- Agent Path Warnings
    local quad = MOAIGfxQuad2D.new()
    quad:setTexture(resources.getPath("uitr/aim.png"))
    quad:setRect(-10, -10, 10, 10)
    resources.insertResource("uitrShoot", quad)
    local quad = MOAIGfxQuad2D.new()
    quad:setTexture(resources.getPath("uitr/shout-alert.png"))
    quad:setRect(-10, -10, 10, 10)
    resources.insertResource("uitrShoutAlert", quad)

    -- Guard Track History
    do
        local scale = 10.5
        local quad = MOAIGfxQuad2D.new()
        quad:setTexture(resources.getPath("uitr/footprint-trail.png"))
        quad:setRect(-scale, -scale, scale, scale)
        resources.insertResource("uitrFootprintTrail", quad)
        local quad = MOAIGfxQuad2D.new()
        quad:setTexture(resources.getPath("uitr/footprint-trail-diag.png"))
        quad:setRect(-scale, -scale * 1.5, scale, scale * 1.5)
        resources.insertResource("uitrFootprintTrailDiag", quad)
        local quad = MOAIGfxQuad2D.new()
        quad:setTexture(resources.getPath("uitr/footprint-trail-question.png"))
        quad:setRect(-scale, -scale, scale, scale)
        resources.insertResource("uitrFootprintQuestion", quad)
        local quad = MOAIGfxQuad2D.new()
        quad:setTexture(resources.getPath("uitr/footprint-trail-question-diag.png"))
        quad:setRect(-scale, -scale * 1.5, scale, scale * 1.5)
        resources.insertResource("uitrFootprintQuestionDiag", quad)
        quad:setTexture(resources.getPath("uitr/footprint-trail-question-flip.png"))
        quad:setRect(-scale, -scale, scale, scale)
        resources.insertResource("uitrFootprintQuestionFlip", quad)
        local quad = MOAIGfxQuad2D.new()
        quad:setTexture(resources.getPath("uitr/footprint-trail-question-diag-flip.png"))
        quad:setRect(-scale, -scale * 1.5, scale, scale * 1.5)
        resources.insertResource("uitrFootprintQuestionDiagFlip", quad)
    end
end

return {initUitrResources = initUitrResources}
