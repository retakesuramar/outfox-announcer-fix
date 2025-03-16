# outfox-announcer-fix

Announcer grade audios in OutFox are really broken. This is because StepMania used to have only 7 grades in total. In OutFox, the number of grades can differ per theme, for example the default theme (SoundWaves) has 17 grades. But the logic to play the audio is still based on having only 7 grades. For example:

- If you got grade A+ in SoundWaves, that is grade number 6, but in StepMania, grade 6 is grade C. The announcer audio for grade C will play
- If you got grade B in SoundWaves, that is grade number 10 - StepMania code doesn't understand that so no audio will play.

There is no easy fix for this, as the code to play the correct announcer audio is in OutFox itself, but there is no way for it to "know" what grades are used by the current theme and what each means.

I "fixed" this by essentially disabling the built-in logic by renaming the relevant directories so OutFox can't find them. Then wrote the logic in Lua instead. I had to account for the "evaluation new record" audio too, even though that works correctly, because I need to make sure a grade audio and new record audio don't play at the same time.

## Example for SoundWaves theme

I've done a mapping from SoundWaves grades to legacy announcer grades, my first pass (and the one I put in this repo) is the canonical one:

- Announcer grade "aaa" is used for SoundWaves grades AAA+, AAA
- Announcer grade "aa" is used for SoundWaves grades AA+, AA, AA-
- Announcer grade "a" is used for SoundWaves grades A+, A, A-
- Announcer grade "b" is used for SoundWaves grades B+, B, B-
- Announcer grade "c" is used for SoundWaves grades C+, C, C-
- Announcer grade "d" is used for SoundWaves grades D+, D, D-

(Side note: This mapping didn't seem to work great for me in terms of grade distribution matching what I was used to. I think this is because grade thresholds are set differently (the thresholds themselves are listed in the theme, but I have reason to believe they are interpreted a bit differently by OutFox/SoundWaves than in legacy StepMania). In particular in my local setup, I tweaked AA+ and AA to map to aaa, and A+ to aa, but YMMV.)

Use this example by:

- Adding the Lua code to your SoundWaves theme (replace the final return statement in "BGAnimations/ScreenEvaluation underlay/default.lua" with the contents of "example-soundwaves-grade-code.lua" from this repo)
- Renaming your announcer directories (for whichever announcer you have selected) with the evaluation prefix to have the eval prefix instead (for example, "evaluation a" renamed to "eval a")
  - Don't rename "evaluation cheer" because that can play at the same time as other audios, but still rename "evaluation new record" to "eval new record"

Note that my Lua code doesn't distinguish the "evaluation" and "evaluation final" audios. In the announcer pack I use, the audios for final and non-final are identical, so I didn't have to worry about it.

## Other themes

You would have to make similar changes in other themes, including ones which were working previously. For me, in addition to SoundWaves I use Alpha V Dance, SM5-Legacy and DDR A. The latter two were working before as they use 7 grade systems, but after renaming evaluation to eval, I had to "fix" them too (using a similar Lua but with a reduced mapping for 7 grades rather than 17).

For Alpha V Dance, it also has 17 grades, but they are named differently. For example, in SoundWaves, grade number 1 is AAA+, 7 is A and 9 is B+. In Alpha V Dance, grade number 1 is ****, grade 7 is S- and 9 is A. Despite this, I used the same mapping for both, as the thresholds for both themes are set identically in terms of the grade numbers.
