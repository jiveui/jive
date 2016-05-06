import massive.munit.TestSuite;

import jive.ComponentTest;
import jive.DataBindingTest;
import jive.LayoutTest;
import jive.SvgTest;
import jive.SwiperTest;
import jive.TemplatedComponentTest;
import jive.WindowTest;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		

	public function new()
	{
		super();

		add(jive.ComponentTest);
		add(jive.DataBindingTest);
		add(jive.LayoutTest);
		add(jive.SvgTest);
		add(jive.SwiperTest);
		add(jive.TemplatedComponentTest);
		add(jive.WindowTest);
	}
}
