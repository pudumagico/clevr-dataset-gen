import json

def build_fact(name, *args):
    return name + '(' + ','.join([ str(a) for a in args ]) + ').'

facts = []

with open('output/CLEVR_scenes.json') as json_file:
    data = json.load(json_file)
    for p in data['scenes'][0]['objects']:
        coords = p['3d_coords']
        material = p['material']
        color = p['color']
        size = p['size']
        shape = p['shape']
        print(coords,material,color,size,shape)
        facts.append(build_fact('object', int(coords[0]), int(coords[1])))

print(facts)