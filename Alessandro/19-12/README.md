# Test with Sensor Array Analyzer

See [test_sensor_array](test_sensor_array.m) and [test_sensor_array](test_sensor_array_steering.m)

Used sensor array chebyshev coefficient
```mathematica
sll = 41;
Array.Taper = chebwin(5, sll);
```

or our coefficient

```mathematica
%sll = 41;
%Array.Taper = chebwin(5, sll);
Array.Taper=[0.1393  0.7215 1 0.7215 0.1393]';
```


![](fig/2021-12-19-12-11-17.png)