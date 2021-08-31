import numpy as np
import pandas as pd
from datetime import datetime as dt
from matplotlib import pyplot as plt
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.tsa.arima.model import ARIMA
from pandas.plotting import register_matplotlib_converters
register_matplotlib_converters()

def arima(df):
    decomposition = seasonal_decompose(df)
    model = ARIMA(df, order=(1,1,1))
    results = model.fit()
    plt.plot(df)
    plt.plot(results.fittedvalues, color='red')
    #results.plot_predict('2020-07-08', '2021-07-08', dynamic=True, ax=ax, plot_insample=False)
    #results.predict('2020-07-08', '2021-07-08', dynamic=True, plot_insample=False)
    results.plot_predict('2020-07-08', '2021-07-08')
    plt.show()
    return results

def main():
    custom_date_parser = lambda x: dt.strptime(x, "%Y-%m-%d %H:%M:%S")

    #df = pd.read_csv(
        #"./power_usage_2016_to_2020.csv",
        #parse_dates=["StartDate"],
        #date_parser=custom_date_parser,
        #).dropna()
    # FixedDates
    df = pd.read_csv(
        "./power_usage_2016_to_2020.csv",
        ).dropna()
        #na_values=["0.000"]
#.replace("0.000", np.NaN)
    times = pd.DataFrame(
        {'Hours': pd.date_range('2016-06-01', '2020-07-08', freq='1H', closed='left')}
    )
    #df['StartDateTime'] = pd.to_datetime(times)
    df['StartDateTime'] = times['Hours']

    print(df.head(20))
    print(df.tail(5))

    df2 = df[['StartDateTime', 'Value (kWh)']]
    dailydf = df2.groupby(pd.Grouper(key='StartDateTime', freq='D')).sum()
    print(dailydf.head(20))
    #dailydf.plot()
    #print(dailydf[dailydf < 1])

    weeklydf = df2.groupby(pd.Grouper(key='StartDateTime', freq='7D')).sum()
    print(weeklydf.head(20))
    #weeklydf.plot()
    results = arima(weeklydf)
    #results.plot_predict('2020-07-08', '2021-07-08', dynamic=True, ax=ax, plot_insample=False)

    monthlydf = df2.groupby(pd.Grouper(key='StartDateTime', freq='M')).sum()
    print(monthlydf.head(20))
    #acf = pd.plotting.autocorrelation_plot(monthlydf)
    #acf.set_xlim([0, 50])
    #monthlydf.plot()
    #arima(monthlydf)


    #initialPlot(df)
    plt.show()

    #dfFixedDates = pd.read_csv(
        #"./power_usage_2016_to_2020.csv",
        #).dropna()

    #times = pd.DataFrame(
        #{'Hours': pd.date_range('2016-06-01', '2020-07-08', freq='1H', closed='left')}
     #)

    #rollingMeanSD(df, plt)
    #plt.show()

    print("END")


if __name__ == "__main__":
    # execute only if run as a script
    main()


