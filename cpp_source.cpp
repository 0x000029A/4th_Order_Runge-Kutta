#include <iostream>
using namespace std;

float h, X0, Y0, N, k{ 0.0009906f };

float diff_Fun(float x, float y = 0) {
	return k * y * (1000.0f - y);
}

float k1(float x, float y = 0) {
	return h * diff_Fun(x, y);
}

float k2(float x, float y = 0) {
	return h * diff_Fun(x + 0.5f * h, y + 0.5f * k1(x, y));
}

float k3(float x, float y = 0) {
	return h * diff_Fun(x + 0.5f * h, y + 0.5f * k2(x, y));
}

float k4(float x, float y= 0) {
	return h * diff_Fun(x + h, y + k3(x, y));
}

int main() {
	cout << "Enter the number of mesh points, x0, and Y(x0)" << endl;
	cin >> N >> X0 >> Y0; h = 7 / N;

	float* time_points = new float[N + 1] { 0 };
	float* Y_F = new float[N + 1] { 0 };

	Y_F[0] = Y0;
	time_points[0] = X0;

	for (int i = 1; i < N; i++) {
		Y_F[i] = Y_F[i - 1] + (1.0f / 6.0f) * (k1(time_points[i - 1], Y_F[i - 1]) + 2.0f * k2(time_points[i - 1], Y_F[i - 1]) + 2.0f * k3(time_points[i - 1], Y_F[i - 1]) + k4(time_points[i - 1], Y_F[i - 1]));
		cout << Y_F[i] << "\t" << i << endl;
		time_points[i] = time_points[i - 1] + h;
	}

	return 0;
}
