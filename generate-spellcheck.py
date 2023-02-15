import sys
import yaml
import io
import os

CUSTOM_WORD_LIST_FILENAME = '.wordlist.txt'

def find_wordlist_files(path):
    wordlist_paths = []
    for root, dirs, files in os.walk(path):
        for file in files:
            if file.endswith(CUSTOM_WORD_LIST_FILENAME):
                wordlist_paths.append(os.path.join(root, file))
    return wordlist_paths
    
spell_check_yaml_path = sys.argv[1]
markdown_base_path = sys.argv[2]

with open(spell_check_yaml_path, 'r+') as file:
    spell_check_yaml = yaml.load(file, Loader=yaml.SafeLoader)
    wordlist_paths = find_wordlist_files(markdown_base_path)
    spell_check_yaml['matrix'][0]['dictionary']['wordlists'].extend(wordlist_paths)
    yaml.dump(file, spell_check_yaml)