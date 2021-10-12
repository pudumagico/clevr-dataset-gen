import sys
import re
from typing import Sized

def parse_models(models_file):
    
    color = re.compile(r'hasColor\(\d,\w+\)')
    shape = re.compile(r'hasShape\(\d,\w+\)')
    size = re.compile(r'hasSize\(\d,\w+\)')
    texture = re.compile(r'hasTexture\(\d,\w+\)')
    
    out_color = re.compile(r'outHasColor\(\d,\w+\)')
    out_shape = re.compile(r'outHasShape\(\d,\w+\)')
    out_size = re.compile(r'outHasSize\(\d,\w+\)')
    out_texture = re.compile(r'outHasTexture\(\d,\w+\)')
    
    models = []
    next_line_model = False
    with open(models_file) as file:
        for line in file.readlines():
            if next_line_model:
                models.append(line.strip())
                next_line_model = False
            if 'Answer' in line:
                next_line_model = True


    positive_models = []
    negative_models = []
    for model in models:
        out_positions = []
        positive_model = ''
        negative_model = ''
        
        colors = color.findall(model)            
        shapes = shape.findall(model)            
        sizes = size.findall(model)         
        textures = texture.findall(model)            

        positive_model = colors + shapes + sizes + textures
        positive_model = ' '.join(positive_model)
        positive_models.append(positive_model)
        
        out_colors = out_color.findall(model)
        out_shapes = out_shape.findall(model)            
        out_sizes = out_size.findall(model)         
        out_textures = out_texture.findall(model)            
        
        for e in out_colors:
            position = int(re.search(r'\d', e).group())
            if position and position not in out_positions:
                out_positions.append(position)
            negative_model += re.sub('hasOutColor', 'hasColor', e) + ' '
        for e in out_shapes:
            negative_model += re.sub('hasOutShape', 'hasShape', e) + ' '
        for e in out_sizes:
            negative_model += re.sub('hasOutSize', 'hasSize', e) + ' '
        for e in out_textures:
            negative_model += re.sub('hasOutTexture', 'hasTexture', e) + ' '
            
        for e in colors:
            position = int(re.search(r'\d', e).group())
            if position in out_positions:
                continue
            else:
                negative_model += e + ' '
        for e in shapes:
            position = int(re.search(r'\d', e).group())
            if position in out_positions:
                continue
            else:
                negative_model += e + ' '

        for e in sizes:
            position = int(re.search(r'\d', e).group())
            if position in out_positions:
                continue
            else:
                negative_model += e + ' '

        for e in textures:
            position = int(re.search(r'\d', e).group())
            if position in out_positions:
                continue
            else:
                negative_model += e + ' '

        
        negative_models.append(negative_model.strip())
    
    print(positive_models)
    print(negative_models)
    
    for i in range(len(positive_models)):
        text_file = open("asp_models/positive_" + str(i) + ".lp", "w")
        text_file.write(positive_models[i])
        text_file.close()
        
    for i in range(len(negative_models)):
        text_file = open("asp_models/negative_" + str(i) + ".lp", "w")
        text_file.write(negative_models[i])
        text_file.close()
    

if __name__ == '__main__':
    base_model = parse_models(sys.argv[1])
