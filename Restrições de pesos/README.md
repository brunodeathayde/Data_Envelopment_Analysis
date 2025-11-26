import pulp as pl

# Modelo CCR orientado a outputs

# Dados de exemplo: 15 DMUs, 2 inputs e 1 output
# (valores fictícios apenas para ilustrar)
inputs = [
    [3, 5], [2, 8], [4, 6], [5, 7], [6, 9],
    [3, 4], [7, 8], [2, 3], [4, 5], [5, 6],
    [6, 7], [3, 6], [2, 4], [7, 9], [8, 10]
]

outputs = [
    [5], [6], [8], [7], [9],
    [4], [10], [3], [6], [7],
    [8], [5], [4], [11], [12]
]

n_dmus = len(inputs)
n_inputs = len(inputs[0])
n_outputs = len(outputs[0])

efficiencies = []

for dmu in range(n_dmus):
    # Variáveis de decisão (u para outputs, v para inputs)
    u = [pl.LpVariable(f"u{r}_DMU{dmu}", lowBound=0.0, upBound=1) for r in range(n_outputs)]
    v = [pl.LpVariable(f"v{i}_DMU{dmu}", lowBound=0.0, upBound=1) for i in range(n_inputs)]

    # Modelo DEA
    model = pl.LpProblem(f"DEA_DMUs_{dmu}", pl.LpMaximize)

    # Função objetivo: eficiência da DMU avaliada
    model += pl.lpSum(u[r] * outputs[dmu][r] for r in range(n_outputs))

    # Normalização: soma ponderada dos inputs da DMU avaliada = 1
    model += pl.lpSum(v[i] * inputs[dmu][i] for i in range(n_inputs)) == 1

    # Restrições para todas as DMUs
    for j in range(n_dmus):
        model += (pl.lpSum(u[r] * outputs[j][r] for r in range(n_outputs)) <=
                  pl.lpSum(v[i] * inputs[j][i] for i in range(n_inputs)))

    # Resolver
    model.solve(pl.PULP_CBC_CMD(msg=0))

    efficiency = pl.value(model.objective)
    efficiencies.append(efficiency)

    # Mostrar resultados da DMU
    print(f"DMU {dmu} -> Status = {pl.LpStatus[model.status]}, Eficiência = {efficiency:.2f}")
    for var in model.variables():
        print(var.name, "=", var.varValue)
    print("-" * 40)

print("Eficiências finais de todas as DMUs:", efficiencies)
