/* ===========================================================  
						서브메뉴 이름 클릭시 출력
=========================================================== */

$(document).ready(function() 
{
	$(".check1").click(function() 
		{  
			var str = "";  
			$(".check1").each(function() 
			{  
				if ($(this).is(":checked"))  
				str += $(this).val() + " ";  
			});
			$("#result1").text(str);
			
			var total = $(".check1").length;
			var checked = $(".check1:checked").length;
			if(total != checked) $("#allcheck1").prop("checked", false);
			else $("#allcheck1").prop("checked", true); 

		});
	
	$("#allcheck1").click(function()
	{
		if($(this).is(":checked")) $(".check1").prop("checked", true);
		else $(".check1").prop("checked", false);

		var str = "";

		$(".check1").each(function()
		{
			if($(this).is(":checked"))
			str += $(this).val() + " ";
		});

		$("#result1").text(str);

	});	
		
	$(".check2").click(function() 
		{  
			var str = "";  
			$(".check2").each(function() 
			{  
				if ($(this).is(":checked"))  
				str += $(this).val() + " ";  
			});
			$("#result2").text(str);
			
			var total = $(".check2").length;
			var checked = $(".check2:checked").length;
			if(total != checked) $("#allcheck2").prop("checked", false);
			else $("#allcheck2").prop("checked", true); 

		});
	
	$("#allcheck2").click(function()
	{
		if($(this).is(":checked")) $(".check2").prop("checked", true);
		else $(".check2").prop("checked", false);

		var str = "";

		$(".check2").each(function()
		{
			if($(this).is(":checked"))
			str += $(this).val() + " ";
		});

		$("#result2").text(str);

	});	
		
});

$(document).ready(function() 
{
	$(".check3").click(function() 
		{  
			var str = "";  
			$(".check3").each(function() 
			{  
				if ($(this).is(":checked"))  
				str += $(this).val() + " ";  
			});
			$("#result3").text(str);
			
			var total = $(".check3").length;
			var checked = $(".check3:checked").length;
			if(total != checked) $("#allcheck3").prop("checked", false);
			else $("#allcheck3").prop("checked", true); 

		});
	
	$("#allcheck3").click(function()
	{
		if($(this).is(":checked")) $(".check3").prop("checked", true);
		else $(".check3").prop("checked", false);

		var str = "";

		$(".check3").each(function()
		{
			if($(this).is(":checked"))
			str += $(this).val() + " ";
		});

		$("#result3").text(str);

	});	
		
});

$(document).ready(function() 
{
	$(".check4").click(function() 
		{  
			var str = "";  
			$(".check4").each(function() 
			{  
				if ($(this).is(":checked"))  
				str += $(this).val() + " ";  
			});
			$("#result4").text(str);
			
			var total = $(".check4").length;
			var checked = $(".check4:checked").length;
			if(total != checked) $("#allcheck4").prop("checked", false);
			else $("#allcheck4").prop("checked", true); 

		});
	
	$("#allcheck4").click(function()
	{
		if($(this).is(":checked")) $(".check4").prop("checked", true);
		else $(".check4").prop("checked", false);

		var str = "";

		$(".check4").each(function()
		{
			if($(this).is(":checked"))
			str += $(this).val() + " ";
		});

		$("#result4").text(str);

	});	
	
	$(".check5").click(function() 
	{  
		var str = "";  
		$(".check5").each(function() 
		{  
			if ($(this).is(":checked"))  
			str += $(this).val() + " ";  
		});
		$("#result5").text(str);

	});
		
});














/* ===========================================================  
							전체 선택
=========================================================== */
/*
$(document).ready(function() 
 {
	$('#checkall1').click(function() 
	{
		if($("#checkall1").is(":checked")) $(".check").prop("checked", true);
		else $(".check").prop("checked", false);
		
	});

	$("input[name=subcategory1]").click(function() 
	{
		var total = $("input[name=subcategory1]").length;
		var checked = $("input[name=subcategory1]:checked").length;

		if(total != checked) $("#checkall1").prop("checked", false);
		else $("#checkall1").prop("checked", true); 
	});
});

$(document).ready(function() 
		 {
			$('#checkall2').click(function() 
			{
				if($("#checkall2").is(":checked")) $("input[name=subcategory2]").prop("checked", true);
				else $("input[name=subcategory2]").prop("checked", false);
			});

			$("input[name=subcategory2]").click(function() 
			{
				var total = $("input[name=subcategory2]").length;
				var checked = $("input[name=subcategory2]:checked").length;

				if(total != checked) $("#checkall2").prop("checked", false);
				else $("#checkall2").prop("checked", true); 
			});
		});

$(document).ready(function() 
		 {
			$('#checkall3').click(function() 
			{
				if($("#checkall3").is(":checked")) $("input[name=subcategory3]").prop("checked", true);
				else $("input[name=subcategory3]").prop("checked", false);
			});

			$("input[name=subcategory3]").click(function() 
			{
				var total = $("input[name=subcategory3]").length;
				var checked = $("input[name=subcategory3]:checked").length;

				if(total != checked) $("#checkall3").prop("checked", false);
				else $("#checkall3").prop("checked", true); 
			});
		});

$(document).ready(function() 
		 {
			$('#checkall4').click(function() 
			{
				if($("#checkall4").is(":checked")) $("input[name=subcategory4]").prop("checked", true);
				else $("input[name=subcategory4]").prop("checked", false);
			});

			$("input[name=subcategory4]").click(function() 
			{
				var total = $("input[name=subcategory4]").length;
				var checked = $("input[name=subcategory4]:checked").length;

				if(total != checked) $("#checkall4").prop("checked", false);
				else $("#checkall4").prop("checked", true); 
			});
		});
*/