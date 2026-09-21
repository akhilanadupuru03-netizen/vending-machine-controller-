# Newspaper Vending Machine Controller

A SystemVerilog RTL design of a digital newspaper vending machine controller using a Finite State Machine (FSM).

## Project Description

The vending machine sells a newspaper for 15 cents.

The machine accepts two types of coins:

- Nickel = 5 cents
- Dime = 10 cents

The machine accumulates the inserted amount and releases the newspaper when the total amount reaches or exceeds 15 cents. No change is returned.

## RTL Design

The controller is implemented using an FSM with the following states:

- `S0` – 0 cents
- `S5` – 5 cents
- `S10` – 10 cents
- `DISPENSE` – Newspaper release

The controller returns to the initial state after dispensing the newspaper.

## Inputs

- `clk` – Clock signal
- `reset` – Reset signal
- `nickel` – 5-cent coin input
- `dime` – 10-cent coin input

## Outputs

- `dispense` – Newspaper release signal
- `current_amount` – Current accumulated amount

## Testbench

The SystemVerilog testbench `Newspaper_vending_machine_tb.sv` is used to verify the functionality of the RTL design.

The testbench generates a clock with a 10 ns period and applies reset before starting the tests.

### Test Cases

#### Test 1: Nickel → Dime

```text
Nickel = 5 cents
Dime   = 10 cents

Total = 15 cents
Expected: Newspaper released
..........
###Test 2: dime->dime
Dime = 10 cents
Dime = 10 cents

Total = 20 cents
Expected: Newspaper released, no change returned
###test 3: invalid nickel+ dime together
Nickel = 5 cents
Dime   = 10 cents

Both coins inserted simultaneously
Expected: Input ignored, newspaper not released

