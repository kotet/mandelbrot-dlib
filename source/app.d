import dlib.image : SuperImage;
import std.complex : Complex;

void main(string[] args)
{
	import std.getopt : defaultGetoptPrinter, getopt, GetOptException,
		GetoptResult;
	import dlib.image : savePNG;

	real center_x = 0.0;
	real center_y = 0.0;
	real height = 4.0;
	real width = 4.0;
	uint row = 100;
	uint column = 100;
	size_t judge_iter = 20;
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
	import dlib.image : image;

	return image(row, column);
}

/** 
	A function that determines whether a sequence diverges.
	Returns: 0 (if Sequence diverges) or Speed to diverge
*/
size_t judge(Complex!real c, size_t judge_iter)
{
	return 0;
}
