Overview:

We have provided various UDAFs within BlinkDB. Once BlinkDB is running, all commands work normally. In addition, the following functions are now available:

APPROX_OLS
ERR_APPROX_OLS
PREP_TEST_APPROX_OLS
TEST_APPROX_OLS


Usage and Examples:
APPROX_OLS(x1, x2, ... , xn, y)
	Returns the regression coefficients for dependent variable y and independent variables x1..xn. To include the y-intercept in the calculation, include "1" as the first independent variable. For example:

	SELECT APPROX_OLS(1,x,y,z,u) FROM synthetic_sample;

	will run an ordinary least squares linear regression over synthetic_sample, using x,y,z as independent variables and u as the dependent variable.

ERR_APPROX_OLS(Array(<coefficients>), x1, x2, ..., xn, y)
	Returns the confidence intervals for the coefficients calcuated in APPROX_OLS. For example:

	SELECT ERR_APPROX_OLS(Array(0,1,-2,3),1,x,y,z,u) FROM synthetic_sample;

	will return the confidence intervals for the previous function (APPROX_OLS)

PREP_TEST_APPROX_OLS(Array(<coefficients>), x1, x2, ..., xn, y)
	Returns various quantities required by the TEST_APPROX_OLS function. The function will return the inverse of A and an S^2 value required by the TEST_APPROX_OLS function. For example:
	
	SELECT PREP_TEST_APPROX_OLS(Array(0,1,-2,3),1,x,y,z,u) FROM synthetic_sample;	

TEST_APPROX_OLS(Array(<coefficients>), Array(<inverse of A>), S^2, Key, x1, x2, ..., xn)
	Returns confidence intervals as well as predictions for each row of data, predicting using the given regression. The data returned will be sorted by "Key". The matrix A inverse must be a square matrix, and input by flattening the matrix across rows (Array(row1, row2, rown)). For example:

	SELECT TEST_APPROX_OLS(Array(0,1,-2), Array(0.001, -2.433E-5, -1.684E-5, -2.433E-5, 0.00109, -5.459E-6,-1.684E-5, -5.459E-6, 9.495E-4),23.952,z,1,x,y) FROM synthetic_sample;

	will return the estimates and confidence intervals for independent variables x and y, sorted on z, in synthetic_sample.


Notes:
Be aware that due to restrictions in our version of Hive, nesting commands is not possible. This means that you must run each command separately, ie even though APPROX_OLS returns an array, you cannot do:

SELECT ERR_APPROX_OLS(APPROX_OLS(1,x,y,z,u),1,x,y,z,u) FROM synthetic_sample; 

To generate the synthetic_sample used in these examples, run the final segment of GenerateSyntheticData.m to create the dataset and sample in BlinkDB at an appropriate interval.


Source Code Layout:
To modify BlinkDB we created several UDAFs. These functions can be found at:

$HIVE_HOME/ql/src/java/org/apache/hadoop/hive/ql/udf/approx/ApproxUDAFOrdinaryLeastSquares.java
$HIVE_HOME/ql/src/java/org/apache/hadoop/hive/ql/udf/approx/PrepTestApproxUDAFOrdinaryLeastSquares.java
$HIVE_HOME/ql/src/java/org/apache/hadoop/hive/ql/udf/approx/StdErrUDAFOrdinaryLeastSquares.java
$HIVE_HOME/ql/src/java/org/apache/hadoop/hive/ql/udf/approx/TestApproxUDAFOrdinaryLeastSquares.java

We also had to modify several files in order for Hive to accept our new UDAFs. Specifically, we had to modify the function registry at:

$HIVE_HOME/ql/src/java/org/apache/hadoop/hive/ql/exec/FunctionRegistry.java

We had to fix a bug present in the SharkDriver code that incorrectly intercepted queries with the token "approx" in them and added additional arguments:

$BLINK_HOME/src/main/scala/shark/SharkDriver.scala

Finally, we had to make changes to the build tools in order to use la4j as a dependency. La4j is a lightweight Java linear algebra library. The ivy file was changed to accomodate this toolset:

$HIVE_HOME/ql/ivy.xml

For a complete list of changed files, as well as the actual files changed, see our fork of the BlinkDB project located at https://github.com/nharada1/blinkdb and the associated submodule https://github.com/nharada1/hive_blinkdb



