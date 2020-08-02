using Microsoft.Office.Interop.Excel;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;

namespace TDG.CORE.ETL.EXCEL
{
    public class ExcelHelper
    {
        //http://msdn.microsoft.com/en-us/library/ms633522%28v=vs.85%29.aspx
        [DllImport("User32.dll", SetLastError = true )]
        public static extern int GetWindowThreadProcessId(IntPtr hWnd, ref int lpdwProcessId);

        public Application GetApplication() => excel;

        int processId =0;
        IntPtr xlHWND;
        Process xlProcess;
        Application excel;
        Workbooks wbs;
        Workbook wb;
        Worksheet ws;
        Sheets wss;
        Range allWorksheetColumns;
        Range tableColumns;
        Range tableRows;
        ListObjects listObjects;
        string wsName = "";

        static bool saveChanges = false;
        static List<string> columnHeaders = new List<string>();

        public ExcelHelper()
        {
            excel = new Application();
            
            xlHWND = (IntPtr)excel.Hwnd;

            GetWindowThreadProcessId(xlHWND, ref processId);
            
            xlProcess = Process.GetProcessById(processId);

            wbs = excel.Workbooks;
            
            wb = wbs.Add();

            wss = wb.Sheets;

            ws = wss[1];

            columnHeaders = new List<string>();
        }

        void NAR(object o)
        {
            try
            {
                while (System.Runtime.InteropServices.Marshal.ReleaseComObject(o) > 0) { }
            }
            catch { }
            finally{o = null;}
        }

        public string SaveFile(bool save = true)
        {
            var whereAmI = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);

            var now = DateTime.Now.ToString("yyyy-MM-dd");

            var fileName = Path.Combine(whereAmI, $"{"TDG-PROVISIONS"}-{now}.xls");

            excel.DisplayAlerts = false;

            wb.SaveAs(fileName);

            return fileName;
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
            wbs.Close();
            NAR(allWorksheetColumns);
            NAR(tableColumns);
            NAR(tableRows);
            NAR(listObjects);
            NAR(ws);
            NAR(wss);
            NAR(wb);
            NAR(wbs);
            excel.Quit();
            NAR(excel);

            GC.Collect();
            GC.WaitForPendingFinalizers();

            if (xlProcess != null && xlProcess.HasExited)
            {
                xlProcess.Kill();
            }
        }
        public void Hide()
        {
            excel.Visible = false;
        }

        public void Show()
        {
            excel.Visible = true;
        }

        public void CreateNewWorksheet()
        {
            ws = wss.Add(After: wss[wss.Count]);
            allWorksheetColumns = ws.Columns;
            allWorksheetColumns.NumberFormat = "@";
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

        public void SetWorksheetName(string name)
        {
            ws.Name = name;
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
            tableRows = ws.get_Range((Microsoft.Office.Interop.Excel.Range)ws.Cells[2, 1], (Microsoft.Office.Interop.Excel.Range)ws.Cells[RowsCount + 1, ColumnsCount]);

            //write the whole body in one go
            tableRows.Value = Cells;

            //make it a table
            tableColumns = ws.get_Range((Microsoft.Office.Interop.Excel.Range)ws.Cells[1, 1], (Microsoft.Office.Interop.Excel.Range)ws.Cells[RowsCount + 1, ColumnsCount]);
            FormatAsTable($"Table{tempTableNumbers++}", "TableStyleLight9");

            //make all columns a decent size
            tableColumns.ColumnWidth = 35;
        }

        public void FreezeFrame(int column, int row)
        {
            foreach (Window win in excel.Windows)
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
            NAR(firstSheet);
        }

        void FormatAsTable(string TableName, string TableStyleName)
        {
            listObjects = ws.ListObjects;
            listObjects.Add(XlListObjectSourceType.xlSrcRange, tableColumns, System.Type.Missing, XlYesNoGuess.xlGuess, System.Type.Missing).Name = TableName;
            tableColumns.Select();
            listObjects[TableName].TableStyle = TableStyleName;
        }
    }
}