from spellchecker import SpellChecker

spell = SpellChecker(language=None, local_dictionary=sys.argv[1])

spell.word_frequency.load_words([
'concessoli',
'adducono',
'presì',
'notisi',
'semi-prove',
'diramassero',
'scemarlo',
'indicandone',
])