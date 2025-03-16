# outfox-announcer-fix

Announcer grade audios in OutFox are really broken. This is because StepMania used to have only 7 grades in total. In OutFox, the number of grades can differ per theme, for example the default theme (SoundWaves) has 17 grades. But the logic to play the audio is still based on having only 7 grades. For example, if you got grade A+ in SoundWaves, that is grade number 6, but in StepMania, grade 6 is grade C. The announcer audio for grade C will play. If you got grade B in SoundWaves, that is grade number 10 - StepMania code doesn't understand that so no audio will play.

This is a very hacky fix for this problem. Use it by:

- Adding the Lua code to your SoundWaves theme
- Renaming your announcer directories with the evaluation prefix to have the eval prefix instead
