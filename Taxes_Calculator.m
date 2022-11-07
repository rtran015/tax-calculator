% Income tax calculator to compare Roth vs Tradational contributions

grossincome = 43000;
deductions = 12550;
contribution = 25000;

taxableincome = grossincome - deductions;
federaltax = 0; statetax = 0;

% Initialize Roth variables
rothTaxableIncome = taxableincome;
rothfederaltax = 0;

% Initialize Traditional variables
tradTaxableIncome = taxableincome - contribution;
tradfederaltax = 0;

%% Set up variables for federal tax brackets

% 10%	$0 to $9,950	        10% of taxable income
fb1max = 9950; fb1taxrate = 10/100; fb1tax = fb1max*fb1taxrate;  

% 12%	$9,951 to $40,525	    $995 plus 12% of the amount over $9,950
fb2max = 40525; fb2taxrate = 12/100; fb2tax = (fb2max-fb1max-1)*fb2taxrate; fb2taxcum = fb1tax+fb2tax;

% 22%	$40,526 to $86,375	    $4,664 plus 22% of the amount over $40,525
fb3max = 86375; fb3taxrate = 22/100; fb3tax = (fb3max-fb2max-1)*fb3taxrate; fb3taxcum = fb3tax + fb2taxcum;

% 24%	$86,376 to $164,925	    $14,751 plus 24% of the amount over $86,375
fb4max = 164925; fb4taxrate = 24/100; fb4tax = (fb4max-fb3max-1)*fb4taxrate; fb4taxcum = fb4tax + fb3taxcum;

% 32%	$164,926 to $209,425	$33,603 plus 32% of the amount over $164,925
fb5max = 209425; fb5taxrate = 32/100; fb5tax = (fb5max-fb4max-1)*fb5taxrate; fb5taxcum = fb5tax + fb4taxcum;

% 35%	$209,426 to $523,600	$47,843 plus 35% of the amount over $209,425
fb6max = 523600; fb6taxrate = 35/100; fb6tax = (fb6max-fb5max-1)*fb6taxrate; fb6taxcum = fb6tax + fb5taxcum;

% 37%	$523,601 or more	    $157,804.25 plus 37% of the amount over $523,600
fb7taxrate = 37/100; 

%% Set up variables for state tax brackets

% 1%	    $0 to $9,325.	        1% of taxable income.
b1max = 9325;
b1taxrate = 1/100;

% 2%	    $9,326 to $22,107.	    $93.25 plus 2% of the amount over $9,325.
b2max = 22107;
b2taxrate = 2/100;

% 4%	    $22,108 to $34,892.	    $348.89 plus 4% of the amount over $22,107.
b3max = 34892;
b3taxrate = 4/100;

% 6%	    $34,893 to $48,435.	    $860.29 plus 6% of the amount over $34,892.
b4max = 48435;
b4taxrate = 6/100; 

% 8%	    $48,436 to $61,214.	    $1,672.87 plus 8% of the amount over $48,435.
b5max = 61214;
b5taxrate = 8/100;

% 9.30%	    $61,215 to $312,686.	$2,695.19 plus 9.3% of the amount over $61,214.
b6max = 312686;
b6taxrate = 9.3/100;

% 10.30%	$312,687 to $375,221.	$26,082.09 plus 10.3% of the amount over $312,686.
b7max = 375221;
b7taxrate = 10.3/100;

% 11.30%	$375,222 to $625,369.	$32,523.20 plus 11.3% of the amount over $375,221.
b8max = 625369;
b8taxrate = 11.3/100;

% 12.30%	$625,370 or more.	    $60,789.92 plus 12.3% of the amount over $625,369.
b9taxrate = 12.3/100;

%% Determine taxes owed in each bracket for Federal and State

%Federal Taxes
if taxableincome > fb6max
    federaltax = fb6taxcum + (taxableincome - fb6max)*fb7taxrate;
elseif taxableincome > fb5max
    federaltax = fb5taxcum + (taxableincome - fb5max)*fb6taxrate;
elseif taxableincome > fb4max
    federaltax = fb4taxcum + (taxableincome - fb4max)*fb5taxrate;
elseif taxableincome > fb3max
    federaltax = fb3taxcum + (taxableincome - fb3max)*fb4taxrate;
elseif taxableincome > fb2max
    federaltax = fb2taxcum + (taxableincome - fb2max)*fb3taxrate;
elseif taxableincome > fb1max
    federaltax = fb1tax + (taxableincome - fb1max)*fb2taxrate;
else
    federaltax = taxableincome*fb1taxrate;
end

%State Taxes (come back to this)

%% Determine taxes owed in each bracket for Federal based on Traditional and Roth
% Federal Taxes for Traditional
if tradTaxableIncome > fb6max
    tradfederaltax = fb6taxcum + (tradTaxableIncome - fb6max)*fb7taxrate;
elseif tradTaxableIncome > fb5max
    tradfederaltax = fb5taxcum + (tradTaxableIncome - fb5max)*fb6taxrate;
elseif tradTaxableIncome > fb4max
    tradfederaltax = fb4taxcum + (tradTaxableIncome - fb4max)*fb5taxrate;
elseif tradTaxableIncome > fb3max
    tradfederaltax = fb3taxcum + (tradTaxableIncome - fb3max)*fb4taxrate;
elseif tradTaxableIncome > fb2max
    tradfederaltax = fb2taxcum + (tradTaxableIncome - fb2max)*fb3taxrate;
elseif tradTaxableIncome > fb1max
    tradfederaltax = fb1tax + (tradTaxableIncome - fb1max)*fb2taxrate;
else
    tradfederaltax = tradTaxableIncome*fb1taxrate;
end

% Federal Taxes for Roth
if rothTaxableIncome > fb6max
    rothfederaltax = fb6taxcum + (rothTaxableIncome - fb6max)*fb7taxrate;
elseif rothTaxableIncome > fb5max
    rothfederaltax = fb5taxcum + (rothTaxableIncome - fb5max)*fb6taxrate;
elseif rothTaxableIncome > fb4max
    rothfederaltax = fb4taxcum + (rothTaxableIncome - fb4max)*fb5taxrate;
elseif rothTaxableIncome > fb3max
    rothfederaltax = fb3taxcum + (rothTaxableIncome - fb3max)*fb4taxrate;
elseif rothTaxableIncome > fb2max
    rothfederaltax = fb2taxcum + (rothTaxableIncome - fb2max)*fb3taxrate;
elseif rothTaxableIncome > fb1max
    rothfederaltax = fb1tax + (rothTaxableIncome - fb1max)*fb2taxrate;
else
    rothfederaltax = rothTaxableIncome*fb1taxrate;
end

%% Determine take homes
tradtakehome = grossincome - tradfederaltax;
rothtakehome = grossincome - rothfederaltax;


%% Print Statements
fprintf('Traditional: The federal taxes owed for a gross income of $%.i, which is a taxable income of $%.i is $%5.2f. Takehome: %5.2f. \n', grossincome, tradTaxableIncome, tradfederaltax, tradtakehome);
fprintf('Roth: \t\t The federal taxes owed for a gross income of $%.i, which is a taxable income of $%.i is $%5.2f. Takehome: %5.2f. \n', grossincome, rothTaxableIncome, rothfederaltax, rothtakehome);

%% Calculations for numbers in retirement
% Assume we now invest the entire take home
n = 30; r = 7/100;
tradport = tradtakehome*(1+r)^n;
rothport = rothtakehome*(1+r)^n;
