import sys
import clingo

def _solution_to_assumptions(self, solution):
    assumptions = []
    for j,k in solution.hasShape.items():
        assumptions += [ Function('hasShape', [Number(j), String(m)]) ]

    return assumptions

def generate_base_model(asp_program):
    ctl = clingo.Control()
    ctl.load(asp_program)
    ctl.ground([("base", [])])
    model_handler = ctl.solve(yield_=True)
    model = model_handler.model()
    models = []
    with ctl.solve(yield_=True) as handle:
        for model in handle:
            for symbol in model.symbols(shown=True):
                # models.append(symbol)
                print(symbol)
            # models.append(model.symbols(atoms=True))

    print(models)
    return model

if __name__ == '__main__':
    base_model = generate_base_model(sys.argv[1])
    # print(base_model)
    # for s in base_model.symbols():
    #     print(s)