import math
import os
from pathlib import Path
import re
import zipfile

class AnnotatedWord(object):    
  """AnnotatedWord encapsulates the annotations provided in the data.

  List of fields:
  word - the original word surface form
  w - normalized (lowercased) word
  tt - the array of annotations from the first interpretation
  stem - the stem of the word (if available), or normalized word (if stem is not available, i.e. when marked with NR)
  """                               
  def __init__(self, word, ann):                             
    self.word = word.strip()                               
    self.w = self.word.lower()                                  
    interpretations = ann.strip().split(';')
    # Just use the first interpretation.                   
    tt = interpretations[0].split('+')
    if 'PROP' in tt:
        self.label = 'B-PER'
    else:
        self.label = 'O'
    self.tt = tt                                         
    stem = tt[0]
    if tt[0] == "Error" or tt[0] == "NR":                  
        stem = self.w                                      
    self.stem = stem

import os                                                      
import sys   

def process_file(filename, process_fn, limit=None):     
    """Reads and processes the input file with annotations (in Tugan Tel corpus format).

    The function process_fn should take one instance of AnnotatedWord and return
    its outputs. This function yields that result back to caller. If process_fn
    returns None, this output is skipped.
    If limit is specified, it instructs the processor to process at most that
    many input words.
      """
    with open(filename) as f:                                 
        lines = f.readlines()                                  
                                                              
    count = 0                                 
    for k in range(len(lines) // 2):                             
        aw = AnnotatedWord(lines[k * 2], lines[k * 2 + 1])    
        val = process_fn(aw)
        if val is not None:
            yield val
        count += 1    
        if limit and count >= limit:
            return  



def normalized_word(aw):
    """Returns the normalized word.
    For the sentence separator, returns newline."""

    skip_types = {"Type2", "Type3", "Type4"}
    regex = re.compile('[-,\.!?]')
    
    if aw.tt[0] == "Type1": 
        return aw.w + ' ' + aw.label + '\n\n'
    if aw.tt[0] in skip_types: 
        return aw.w + ' ' + aw.label + '\n'
    if len(regex.sub('', aw.w)) <= 2:
        return None
    return aw.w + ' ' + aw.label + '\n'

def main():
    
    path = 'all_texts_in_utf8_renamed_analyzed'
    #Path(path).mkdir(parents=True, exist_ok=True)
    
    
    with zipfile.ZipFile('all_texts_in_utf8_renamed_analyzed_mv1.02.zip', 'r') as zip_ref:
        zip_ref.extractall()

    print('Data unzip')
    #all_file_names = [name for name in os.listdir(path) if '.txt' in name]

    all_file_names = [name for name in os.listdir(path) if '.txt' in name][:2200]
    #all_file_names = ['1_4840_0_1.txt']

    all_text = []
    for FILE in all_file_names:
        all_text.append(''.join(process_file(path+'/'+FILE, normalized_word)))

    len_of_data = len(all_text)

    #with open("data.tmp", "w") as output:
    #    output.write(''.join(all_text[:math.ceil(len_of_data * 0.25)]))

    with open("dev.txt", "w") as output:
        output.write(''.join(all_text[:math.ceil(len_of_data * 0.25)]))
    with open("train.txt", "w") as output:
        output.write(''.join(all_text[math.ceil(len_of_data * 0.25):math.ceil(len_of_data * 0.75)]))
    with open("test.txt", "w") as output:
        output.write(''.join(all_text[math.ceil(len_of_data  * 0.75):]))

    print('Data for model was created')    

if __name__ == "__main__":
    main()





