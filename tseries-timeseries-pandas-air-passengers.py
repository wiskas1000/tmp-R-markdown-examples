import numpy as np
import pandas as pd
from matplotlib import pyplot as plt
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.tsa.arima_model import ARIMA
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()

def initialPlot(df):
    df.head()
    plt.xlabel('Date')
    plt.ylabel('Number of air passengers')
    plt.plot(df)
    return plt

def rollingMeanSD(df, plt):
    rolling_mean = df.rolling(window = 12).mean()
    rolling_std = df.rolling(window = 12).std()
    plt.plot(df, color = 'blue', label = 'Original')
    plt.plot(rolling_mean, color = 'red', label = 'Rolling Mean')
    plt.plot(rolling_std, color = 'black', label = 'Rolling Std')
    plt.legend(loc = 'best')
    plt.title('Rolling Mean & Rolling Standard Deviation')
    return plt

def arima(df):
    decomposition = seasonal_decompose(df)
    model = ARIMA(df, order=(2,1,2))
    results = model.fit(disp=-1)
    plt.plot(df_log_shift)
    plt.plot(results.fittedvalues, color='red')

def main():
    df = pd.read_csv(
    "https://raw.githubusercontent.com/AileenNielsen/TimeSeriesAnalysisWithPython/master/data/AirPassengers.csv",
    parse_dates=["Month"],
    index_col="Month",
    ).dropna()
    initialPlot(df)
    plt.show()

    rollingMeanSD(df, plt)
    plt.show()

    print("END")


if __name__ == "__main__":
    # execute only if run as a script
    main()


