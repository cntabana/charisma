
<?php
$hospital = '';
if(isset(Yii::app()->session['iduser'])){

 $hospital = Yii::app()->db->createCommand()
    ->select('hopitalName')
    ->from('hospital')
    ->where('iduser=:id', array(':id'=>Yii::app()->session['iduser']))
    ->queryScalar();
}
$this->beginWidget('zii.widgets.CPortlet', array(
  'htmlOptions'=>array(
    'class'=>''
  )
));
$this->widget('bootstrap.widgets.TbMenu', array(
  'type'=>'pills',
  'items'=>array(
    array('label'=>'Create', 'icon'=>'icon-plus', 'url'=>Yii::app()->controller->createUrl('create'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
    array('label'=>'List', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/admin'), 'linkOptions'=>array()),
    array('label'=>'Manage', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/index'),'visible'=>Yii::app()->user->groupe!=1, 'linkOptions'=>array()),
    array('label'=>'Formulaire des sois du patient', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/formulaire',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2,'active'=>true, 'linkOptions'=>array()),
    array('label'=>'Ordonnance Medicale', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/ordonnanceMedicale',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Medical spectacle prescription', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/lunette',array('id'=>$_GET['id'])),'visible'=>Yii::app()->user->groupe!=2, 'linkOptions'=>array()),
    array('label'=>'Bullettin d\'analyse', 'icon'=>'icon-th-list', 'url'=>Yii::app()->controller->createUrl('members/analyseDemande',array('id'=>$_GET['id'])), 'visible'=>Yii::app()->user->groupe!=2,'linkOptions'=>array()),
    array('label'=>'Print', 'icon'=>'icon-print', 'url'=>'javascript:void(0);return false', 'linkOptions'=>array('onclick'=>'printDiv();return false;')),

    ),
));
$this->endWidget();
?>
</hr>
<div class='printableArea'>
<table width="80%" align='center' border=0>
  <tr> 
     <td>
          <p>
            University of Rwanda Medical Insurance Scheme<br>
      Mutuelle de Sante de l'Universite du Rwanda<br>
      B.P. HI-TEL: 531031<br>
      HUYE
          </p>
     </td>
  </tr>

  <tr> 
     <td colspan=3> <h2>
      <center>FORMULAIRE DE SOINS DU PATIENT N° </center>
     </h2></td>
  </tr>

  <tr> 
     <td><h4>Identification</h4></br></td>
  </tr>

  <tr> 
     <td>
            <ul>
              <li>HOPITAL DE : <b><?php echo $hospital;?><b></li>
              <li>NON DU MALADE: <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li></b>
              <li>NUMERO ET CATEGORIE DU MALADE:<b><?php echo CHtml::encode($data->cardnumber); ?></li></b>
              <li>NOM DU MEMBRE PRINCIPAL : <b><?php echo CHtml::encode($data->firstname); ?> <?php echo CHtml::encode($data->middlename); ?> <?php echo CHtml::encode($data->lastname); ?></li></b></li>
              <li>DATE D' ADMISSION : <b><?php echo date('d-m.Y');?><b></li>
              <li>DATE DE SORTIE :</li>
              <li>SERVICE DE :</li>
            </ul>
     </td>
  </tr>

  <tr> 
     <td colspan=3>
            <table border=1 width=100%> 
               <th>Date</th>
               <th>DETAIL DUTRAITEMENT</th>
               <th>COURTS</th>
               <tr height="200px">
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
               </tr>
               <tr >
                <td colspan=2 align='right'>CoutTotal:</td>
                 <td>&nbsp;</td>
                </tr>
                <tr >
                <td colspan=2 align='right'>15%</td>
                 <td>&nbsp;</td>
                </tr><tr >
                <td colspan=2 align='right'>85%</td>
                 <td>&nbsp;</td>
                </tr>
            </table>
     </td>
  </tr>

    <tr>
         <td>Signature du Malade</td>
          <td>Cachet et Signature du Medecin</td>
         <td>Cachet et Signature de
            L 'Administration
              
        </td>
</tr> 
<table>

</div>
<style type="text/css" media="print">
body {visibility:hidden;}
.printableArea{visibility:visible;} 
</style>
<script type="text/javascript">
function printDiv()
{

window.print();

}
</script>


