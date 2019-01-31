#include <so_5/all.hpp>

int main()
{
	try
	{
		so_5::launch( [](so_5::environment_t &) {} );
	}
	catch( const std::exception & x )
	{
		std::cerr << "Error: " << x.what() << std::endl;
	}
}

