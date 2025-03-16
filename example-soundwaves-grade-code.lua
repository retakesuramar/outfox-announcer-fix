local failed = "Grade_Failed";
local best_grade = failed;
for pn in ivalues(GAMESTATE:GetHumanPlayers()) do
    local playerGrade = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetGrade();
    local highScoreIndex = STATSMAN:GetCurStageStats():GetPlayerStageStats(pn):GetPersonalHighScoreIndex();
    if highScoreIndex == 0 then
        SOUND:PlayAnnouncer("eval new record");
        return t;
    end
    if best_grade == failed then
        best_grade = playerGrade;
    elseif playerGrade ~= failed and playerGrade < best_grade then
        best_grade = playerGrade;
    end
end

local gradeMap = {
    Grade_Tier01 = "aaa",
    Grade_Tier02 = "aaa",
    Grade_Tier03 = "aa",
    Grade_Tier04 = "aa",
    Grade_Tier05 = "aa",
    Grade_Tier06 = "a",
    Grade_Tier07 = "a",
    Grade_Tier08 = "a",
    Grade_Tier09 = "b",
    Grade_Tier10 = "b",
    Grade_Tier11 = "b",
    Grade_Tier12 = "c",
    Grade_Tier13 = "c",
    Grade_Tier14 = "c",
    Grade_Tier15 = "d",
    Grade_Tier16 = "d",
    Grade_Tier17 = "d",
    Grade_Failed = "f"
}

local gradeAudio = gradeMap[best_grade];
if gradeAudio then
    SOUND:PlayAnnouncer("eval " .. gradeAudio);
end

return t;
