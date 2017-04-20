import dlib.image : SuperImage;
import std.complex : Complex;

void main(string[] args)
{
	import dlib.image : savePNG;
	import std.getopt : defaultGetoptPrinter, getopt, GetOptException,
		GetoptResult;

	real center_x = -0.7;
	real center_y = 0.0;
	real height = 2.5;
	real width = 2.5;
	uint row = 2048;
	uint column = 2048;
	size_t judge_iter = 100;
	string output_file = "mandel.png";

	GetoptResult helpinfo;
	try
	{
		helpinfo = getopt(args, "center-x", &center_x, "center-y", &center_y,
				"height", &height, "width", &width, "row", &row, "column", &column,
				"judge-iter", &judge_iter, "output-file|o", &output_file);
	}
	catch (Exception e)
	{
		import std.stdio : writeln;

		writeln("Error: ", e.msg, "\nexit");
		return;
	}

	if (helpinfo.helpWanted)
		defaultGetoptPrinter("test", helpinfo.options);

	draw(center_x, center_y, height, width, row, column, judge_iter).savePNG(output_file);
}

SuperImage draw(real center_x, real center_y, real height, real width, uint row,
		uint column, size_t judge_iter)
{
	import dlib.image : hsv, image;
	import std.range : iota;

	auto img = image(row, column);
	foreach (x; 0 .. row)
		foreach (y; 0 .. column)
		{
			Complex!real c;
			c.re = center_x - (width / 2) + (width * (cast(real) x / row));
			c.im = center_y + (height / 2) - (height * (cast(real) y / column));
			auto result = judge(c, judge_iter);
			img[x, y] = (result == 0) ? hsv(0, 0, 0) : hsv(cast(float)(result * 10) % 256, 0.8, 1.0);
		}

	return img;
}

/** 
	A function that determines whether a sequence diverges.
	Returns: 0 (if Sequence diverges) or Speed to diverge
*/
size_t judge(Complex!real c, size_t judge_iter)
{
	import std.complex : abs, complex;

	auto z = complex!real(0, 0);

	foreach (i; 0 .. judge_iter)
	{
		z = z * z + c;
		if (2.0 < z.abs)
			return i + 1;
	}
	return 0;
}
