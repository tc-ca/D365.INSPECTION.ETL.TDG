using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.Linq;

namespace TDG.CORE.ETL.EXCEL
{
    public class ExcelHelper
    {
        public Application GetApplication() => excel;

        Application excel;
        Workbook wb;
        Worksheet ws;

        static bool saveChanges = false;
        static List<string> columnHeaders = new List<string>();

        public ExcelHelper()
        {
            excel = new Application();

            wb = excel.Workbooks.Add();

            ws = wb.Sheets[1];

            ws.Name = "TDG Regulations";

            columnHeaders = new List<string>();
        }



        public void SaveFile(bool save = true)
        {
            saveChanges = save;
        }

        public void Recenter()
        {
            excel.WindowState = Microsoft.Office.Interop.Excel.XlWindowState.xlNormal;
            excel.Top = 25;
            excel.Left = 900;
            excel.Width = 600;
            excel.Height = 900;
        }

        public void Close()
        {
            wb.Close(saveChanges);
            System.Runtime.InteropServices.Marshal.ReleaseComObject(wb);
            excel.Quit();
        }
        public void Hide()
        {
            excel.Visible = false;
        }

        public void Show()
        {
            excel.Visible = true;
        }

        public void CreateNewWorksheet(string sheetName = "")
        {
            ws = wb.Worksheets.Add(After: wb.Sheets[wb.Sheets.Count]);
            ws.Columns.NumberFormat = "@";

            if (!string.IsNullOrEmpty(sheetName)) ws.Name = sheetName;
        }





        //slow way
        public void AddDataTableToExcel(System.Data.DataTable table)
        {
            // Creating Header Column In Excel
            for (int i = 0; i < table.Columns.Count; i++)
            {
                if (!columnHeaders.Contains(table.Columns[i].ColumnName))
                {
                    ws.Cells[1, columnHeaders.Count() + 1] = table.Columns[i].ColumnName;
                    columnHeaders.Add(table.Columns[i].ColumnName);
                }
            }

            // Get the rows
            for (int k = 0; k < table.Rows.Count; k++)
            {
                for (int i = 0; i < table.Columns.Count; i++)
                {
                    ws.Cells[k + 2, i + 1] = table.Rows[k][i].ToString();
                }
            }
        }


        //way faster
        static int tempTableNumbers = 1;
        public void BulkExportDataTableToExcel(System.Data.DataTable table)
        {
            int ColumnsCount;

            if (table == null || (ColumnsCount = table.Columns.Count) == 0)
                throw new Exception("ExportToExcel: Null or empty input table!\n");

            object[] Header = new object[ColumnsCount];

            // column headings               
            for (int i = 0; i < ColumnsCount; i++)
                Header[i] = table.Columns[i].ColumnName;

            //where the headers go
            Microsoft.Office.Interop.Excel.Range HeaderRange = ws.get_Range((Microsoft.Office.Interop.Excel.Range)(ws.Cells[1, 1]), (Microsoft.Office.Interop.Excel.Range)(ws.Cells[1, ColumnsCount]));
            
            //write entire header row in one go
            HeaderRange.Value = Header;

            // DataCells
            int RowsCount = table.Rows.Count;
            object[,] Cells = new object[RowsCount, ColumnsCount];

            for (int j = 0; j < RowsCount; j++)
                for (int i = 0; i < ColumnsCount; i++)
                    Cells[j, i] = table.Rows[j][i];

            //where does the body go
            Microsoft.Office.Interop.Excel.Range RowRange = ws.get_Range((Microsoft.Office.Interop.Excel.Range)ws.Cells[2, 1], (Microsoft.Office.Interop.Excel.Range)ws.Cells[RowsCount + 1, ColumnsCount]);
            
            //write the whole body in one go
            RowRange.Value = Cells;

            //make it a table
            Microsoft.Office.Interop.Excel.Range TableRange = ws.get_Range((Microsoft.Office.Interop.Excel.Range)ws.Cells[1, 1], (Microsoft.Office.Interop.Excel.Range)ws.Cells[RowsCount + 1, ColumnsCount]);
            FormatAsTable(TableRange, $"Table{tempTableNumbers++}", "TableStyleLight9");

            //make all columns a decent size
            SizeAllColumns(RowRange, 35);
        }

        public void FreezeFrame(int column, int row)
        {
            foreach (Window win in excel.Application.Windows)
            {
                win.SplitColumn = column;
                win.SplitRow = row;
                win.FreezePanes = true;
            }
        }

        public void SelectFirstSheet()
        {
            Worksheet firstSheet = excel.Sheets[1];
            firstSheet.Activate();
        }

        void FormatAsTable(Microsoft.Office.Interop.Excel.Range SourceRange, string TableName, string TableStyleName)
        {
            SourceRange.Worksheet.ListObjects.Add(XlListObjectSourceType.xlSrcRange, SourceRange, System.Type.Missing, XlYesNoGuess.xlGuess, System.Type.Missing).Name = TableName;
            SourceRange.Select();
            SourceRange.Worksheet.ListObjects[TableName].TableStyle = TableStyleName;
        }

        void SizeAllColumns(Microsoft.Office.Interop.Excel.Range SourceRange, int columnSize)
        {
            SourceRange.Columns.ColumnWidth = columnSize;
        }
    }
}